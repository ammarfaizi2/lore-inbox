Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbULFSAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbULFSAw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULFSAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:00:52 -0500
Received: from alog0327.analogic.com ([208.224.222.103]:11648 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261559AbULFSAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:00:41 -0500
Date: Mon, 6 Dec 2004 12:57:13 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Bunk <bunk@stusta.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dynamic syscalls revisited
In-Reply-To: <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412061254460.19027@chaos.analogic.com>
References: <1101741118.25841.40.camel@localhost.localdomain> 
 <20041129151741.GA5514@infradead.org>  <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
  <1101748258.25841.53.camel@localhost.localdomain>  <20041205234605.GF2953@stusta.de>
  <1102349255.25841.189.camel@localhost.localdomain>
 <1102353388.25841.198.camel@localhost.localdomain>
 <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Zwane Mwaikambo wrote:

> On Mon, 6 Dec 2004, Steven Rostedt wrote:
>
>> I added the following to my sys_dsyscall routine. The routine that is
>> the only system call for a user process to access dynamic system calls
>> (at anytime), even if dynamic system calls are loaded.
>>
>> 	static int is_tainted = 0;
>>
>> 	if (tainted & TAINT_PROPRIETARY_MODULE) {
>> 		if (!is_tainted) {
>> 			printk(KERN_INFO "Sorry, can't use dynamic system calls with proprietary modules\n");
>> 			is_tainted = 1;
>> 		}
>> 		return -EINVAL;
>> 	}
>>
>> Once a proprietary module is loaded then all dynamic system calls will
>> become useless.
>>
>> This way, only systems that never loaded a proprietary module may be
>> able to use dynamic system calls.  This may suck for those that have
>> NVidia cards, but this may be a start to overcome the problem of
>> allowing binary hooks into default kernels. It also is a way to motivate
>> end users to not use proprietary modules.
>
> I didn't know we were on a crusade to end all binary modules at all costs.
> Why not just make _all_ symbols in the kernel EXPORT_SYMBOL_GPL then? I
> really believe this is taking things to new levels of silliness, we should
> also possibly consider adding code in glibc to stop proprietary
> libraries/applications from running. What do you think?
>
> 	Zwane

Let 'em play their games. We all know how to fork a kernel
that works with our requirements. Currently, 'tainted' can
be zeroed-out with the /proc interface. Code like the demo
above puts one person's policy into the kernel. Policy is
not supposed to be inside the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
