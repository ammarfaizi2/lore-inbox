Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVE0PKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVE0PKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 11:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVE0PKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 11:10:40 -0400
Received: from fw.brightsands.com ([66.63.88.58]:26506 "EHLO mike.caldwell.org")
	by vger.kernel.org with ESMTP id S261794AbVE0PK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 11:10:28 -0400
Date: Fri, 27 May 2005 11:10:17 -0400
From: C.M.Caldwell@Alumni.UNH.EDU
Message-Id: <200505271510.j4RFAHYX010409@mike.caldwell.org>
To: linux-kernel@vger.kernel.org
Subject: Conflict between ntpd system calls and bttv device driver
Cc: c.m.caldwell@Alumni.UNH.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

One line:	Frame grabber times out if ntpd runs with kernel calls

Full:		We run the bttv frame grabber on a Dell-2600 running
		2.6.9-1.667smp (ala Fedora Core 3).  If we run ntpd
		normally, after a variable amount of time (seconds to
		multiple hours), ioctl(dev,VIDIOC_DQBUF,ptr) returns
		EINVAL.  After putting debug writes in the kernel,
		we determined that it is because the request timed out
		due to the fact that the interupt was blocked by a
		higher priority interupt:  the kernel logic for the ntpd
		system calls.

		This doesn't happen on all systems (e.g. a Dell-2650 doesn't
		seem to have this problem), but it will happen with earlier
		versions of the kernel.  Also, the problem occurs even if
		you have stopped ntpd and re-loaded the bttv driver.

		It may be that this can occur under more circumstances than
		outline above but that it is much rarer.  We believe that
		the Dell-2600s multiple PCI busses and its interupt structure
		may make it much more sensitive to having interupts blocked
		for long periods of time.
		
Keywords:	bttv adjtime VIDIOC_DQBUF timeout
Version:	2.6.9-1.667smp

Workaround:	Add "disable kernel" to ntp.conf file and reboot
Oops output:
Shell script:
Environment:
Software:
Processor:	i686 Genuine Intel 2.8GHZ (Dell-2600)
Modules:
Loaded drivers:
Hardware:
lspci:
SCSI:

Comments:	Considering how easy the work-around for us is, this is
		pretty low priority (though it was mighty high until we
		figured out that ntpd was the thing hogging the interupts).
		I wanted to send this in just to make people aware that
		there maybe some timing conflicts.
		sure 
