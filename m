Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUA3HS0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 02:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUA3HS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 02:18:26 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:61071 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266577AbUA3HSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 02:18:24 -0500
Message-ID: <401A0432.3070103@cyberone.com.au>
Date: Fri, 30 Jan 2004 18:13:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Curt <curt@northarc.com>, linux-kernel@vger.kernel.org
Subject: Re: Raw devices broken in 2.6.1? AND- 2.6.1 I/O degraded?
References: <01c501c3e6b9$67225f70$0700000a@irrosa>	<20040129163852.4028c689.akpm@osdl.org>	<020d01c3e6d0$acd78f60$0700000a@irrosa>	<20040129205605.5bd140b2.akpm@osdl.org>	<015301c3e6fb$2dbc22b0$0300000a@falcon> <20040129224629.702e9eca.akpm@osdl.org>
In-Reply-To: <20040129224629.702e9eca.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>"Curt" <curt@northarc.com> wrote:
>
>> >    Or you can put 2.6 on par by setting
>> >    /proc/sys/vm/dirty_background_ratio to 40 and dirty_ratio to 60.
>>
>> Okay will do, is there a good comprehensive resource where I can read up on
>> these (and presumably many other I/O related) variables?
>>
>
>We've been relatively good about keeping the in-kernel documentation up to
>date.  For this stuff, see Documentation/filesystems/proc.txt and
>Documentation/sysctl/vm.txt.
>
>
>> > Longer-term, if your customers are using scsi, you should ensure that the
>> > disks do not use a tag queue depth of more than 4 or 8.  More than that
>> and
>> > the anticipatory scheduler becomes ineffective and you won't get that
>> > multithreaded-read goodness.
>>
>> I've heard-tell of tweaking the elevator paramter to 'deadline', again could
>> you point me to a resource where I can read up on this? And forgive the
>> newbie-question, but is this a boot-time parameter, or a bit I can set in
>> the /proc system, or both?
>>
>
>It's boot-time only.  We were working on making it per-disk but that was
>quite complex and we really didn't get there in time.
>
>So add `elevator=deadline' to your kernel boot command line.  From my
>(brief) testing, it was a significant lose.  It needs more work though:
>2.6+deadline shouldn't be slower than 2.4.x
>
>

Another thing you can do which is runtime per-disk is set
/sys/block/???/queue/iosched/antic_expire to 0 which gives you
something quite like deadline.

>> > Please stay in touch, btw.  If we cannot get applications such as yours
>> > working well, we've wasted our time...
>>
>> I'll do what I can to provide real-world feedback, I want this to work too.
>>
>
>Thanks.
>

I'd be interested in taking a look at the io scheduler if you have
problems with these workloads in future.

