Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263333AbVFYEgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbVFYEgr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbVFYEgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:36:47 -0400
Received: from [203.171.93.254] ([203.171.93.254]:44261 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263333AbVFYEfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:35:51 -0400
Subject: Re: Mismatched suspend2 interfaces == Suspend was aborted
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Haninger <ahaning@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend2-Users <suspend2-users@lists.suspend2.net>
In-Reply-To: <105c793f05062421207c6ad27@mail.gmail.com>
References: <105c793f05062421207c6ad27@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119674219.4170.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Jun 2005 14:36:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

The Suspend2 mailing lists can be found via suspend2.net.

On Sat, 2005-06-25 at 14:20, Andrew Haninger wrote:
> I'm having an odd problem with software-suspend recently. Running the
> latest kernel/suspend2/hibernate, I'm getting an error which is
> confusing me:
> 
> WARNING: The suspend2 scriptlet was written for a different suspend2 interface
>          version from the one in your running kernel. This scriptlet was
>          written for version between 15 and 15 where as the version running
>          in your kernel is 16. Things may not work as expected, but proceeding
>          anyway ...
> 
>  - hibernate: Suspend reported the following errors:
> Suspend was aborted (see dmesg).
> 
> "written for a version between 15 and 15" is the part that is
> confusing me. First, version 15 of what? Second, between a version and
> itself?

The hibernate script is talking about the version of Suspend2's proc
interface (cat /proc/software_suspend/interface_version). With the
change to cryptoapi, I updated the number to 16 (as you correctly guess
below).

> So, I look at dmesg. Here's the stuff it says to give when reporting
> bugs (plus some extra stuff):
> 
> Software Suspend 2.1.9.5: Initiating a software suspend cycle.
> Software Suspend 2.1.9.5: Swapwriter: Signature found.
> Software Suspend 2.1.9.5: Suspending enabled.
> Suspend2: Failed to initialise the compression transform.
> Please include the following information in bug reports:
> - SUSPEND core   : 2.1.9.5
> - Kernel Version : 2.6.12.1
> - Compiler vers. : 3.2
> - Attempt number : 8
> - Pageset sizes  : 3281 (3281 low) and 12192 (12192 low).
> - Parameters     : 1 64 0 1 0 5
> - Calculations   : Image size: 15676. Ram to suspend: 524.
> - Limits         : 49147 pages RAM. Initial boot: 46744.
> - Overall expected compression percentage: 0.
> - Compressor  enabled.
> - Swapwriter active.
>   Swap available for image: 48185 pages.
> - Filewriter inactive.
> - Preemptive kernel.
> - Max extents used: 8
> - No I/O speed stats available.
> 
> 
> I've tried removing /etc/hibernate and /usr/local/sbin/hibernate and
> reinstalling hibernate script 1.08, but I still get this error.
> 
> I think this might have something to do with the new movement to the
> cryptoapi and there's just something I'm not getting.

That's right.

Assuming you compiled LZF cryptoapi support in and want to use it, the
right thing to do is edit your hibernate.conf (probably in
/etc/hibernate) and add the lines:

ProcSetting compressor lzf
ProcSetting disable_encryption 1

If you haven't compiled lzf in, you'll need to include the module in an
initrd/initramfs and load it before doing echo >
/proc/software_suspend/do_resume in the script, so compiling in is the
simpler option.

Hope this helps.

Nigel

