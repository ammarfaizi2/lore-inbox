Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265527AbUEZMMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265527AbUEZMMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUEZMMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:12:16 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:7814 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265527AbUEZMKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:10:11 -0400
Message-ID: <40B48920.70206@yahoo.com.au>
Date: Wed, 26 May 2004 22:10:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
References: <1085568719.2666.53.camel@imp.csi.cam.ac.uk>	 <40B47BC8.2010209@yahoo.com.au> <1085572902.2666.105.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1085572902.2666.105.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> On Wed, 2004-05-26 at 12:13, Nick Piggin wrote:
> 
>>Anton Altaparmakov wrote:
>>
>>>Hi,
>>>
>>>Kernel 2.6.7-rc1-bk crashes on boot with a NULL pointer dereference. 
>>>The kernel is running under VMware if that matters but I don't think it
>>>should.  It was working fine with 2.6.6-rc3-bk kernels.
>>>
>>>I am afraid the only way I could capture the crash was to capture the
>>>vmware screen into a PNG image which is attached.  Maybe I need to setup
>>>some OCR software for in the future...  (-;
>>>
>>>The system running VMware is a P4 2.6Hz with Hyper threading enabled and
>>>/proc/cpuinfo shows two cpus:
>>
>>OK, thanks for that. It would be quite helpful if you edit
>>kernel/sched.c and turn the line #undef SCHED_DOMAIN_DEBUG into
>>#define SCHED_DOMAIN_DEBUG, then compile a kernel with debugging
>>info enabled.
> 
> 
> Looking at kernel/sched.c it already says #define, not #undef!
> 

Oops, yes.

[snip]

> So the dereferencing of one of the two fails.  Considering the offset is
> 0x18 in the NULL dereference it must be the (p)->prio that causes the
> oops and hence p must be NULL.  I will leave you to figure out what that
> means...
> 

Nice detective work.

It tried to dereference a NULL idle thread I'd say.
ie. the CPU hasn't been set up. Please try Ingo's patch.
