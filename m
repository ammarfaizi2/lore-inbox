Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbUA3Gpw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 01:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266440AbUA3Gpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 01:45:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:44422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266422AbUA3Gpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 01:45:51 -0500
Date: Thu, 29 Jan 2004 22:46:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Curt" <curt@northarc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raw devices broken in 2.6.1? AND- 2.6.1 I/O degraded?
Message-Id: <20040129224629.702e9eca.akpm@osdl.org>
In-Reply-To: <015301c3e6fb$2dbc22b0$0300000a@falcon>
References: <01c501c3e6b9$67225f70$0700000a@irrosa>
	<20040129163852.4028c689.akpm@osdl.org>
	<020d01c3e6d0$acd78f60$0700000a@irrosa>
	<20040129205605.5bd140b2.akpm@osdl.org>
	<015301c3e6fb$2dbc22b0$0300000a@falcon>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Curt" <curt@northarc.com> wrote:
>
>  >    Or you can put 2.6 on par by setting
>  >    /proc/sys/vm/dirty_background_ratio to 40 and dirty_ratio to 60.
> 
>  Okay will do, is there a good comprehensive resource where I can read up on
>  these (and presumably many other I/O related) variables?

We've been relatively good about keeping the in-kernel documentation up to
date.  For this stuff, see Documentation/filesystems/proc.txt and
Documentation/sysctl/vm.txt.

>  > Longer-term, if your customers are using scsi, you should ensure that the
>  > disks do not use a tag queue depth of more than 4 or 8.  More than that
>  and
>  > the anticipatory scheduler becomes ineffective and you won't get that
>  > multithreaded-read goodness.
> 
>  I've heard-tell of tweaking the elevator paramter to 'deadline', again could
>  you point me to a resource where I can read up on this? And forgive the
>  newbie-question, but is this a boot-time parameter, or a bit I can set in
>  the /proc system, or both?

It's boot-time only.  We were working on making it per-disk but that was
quite complex and we really didn't get there in time.

So add `elevator=deadline' to your kernel boot command line.  From my
(brief) testing, it was a significant lose.  It needs more work though:
2.6+deadline shouldn't be slower than 2.4.x

>  > Please stay in touch, btw.  If we cannot get applications such as yours
>  > working well, we've wasted our time...
> 
>  I'll do what I can to provide real-world feedback, I want this to work too.

Thanks.
