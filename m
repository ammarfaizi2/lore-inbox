Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCYGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCYGys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCYGyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:54:47 -0500
Received: from harlech.math.ucla.edu ([128.97.4.250]:55939 "EHLO
	harlech.math.ucla.edu") by vger.kernel.org with ESMTP
	id S261439AbVCYGye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:54:34 -0500
Date: Thu, 24 Mar 2005 22:54:21 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: Re: Disc driver is module, software suspend fails
Message-ID: <Pine.LNX.4.61.0503242248530.7785@xena.cft.ca.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005, Pavel Machek wrote: 
> This is WONTFIX for 2.6.11, but you can be pretty sure it is going to 
> be fixed for SuSE 9.3, and patch is already in 2.6.12-rc1. Feel free 
> to betatest SuSE 9.3 ;-). 

Unfortunately the celebration was premature.  I compiled 2.6.12-rc1,
noticing the new feature that you can see or alter the swap device 
number in /sys/power/resume.  So I'm able to suspend... but not to
resume, since the driver still isn't loaded at the time of resuming.

I tried some cowboy programming like this: in kernel/power/disk.c I
changed software_resume to be not static (i.e. extern) and not a
late_initcall.  In init/main.c, in init(), just after do_basic_setup(),
I inserted a call to software_resume().  This did not even cause a
kernel panic as I had expected; there was no sign on the console, in
/var/log/boot.msg or anywhere else that software_resume had ever been
called, even with a suspended image in the swap partition.

It was worth a try, but not much more, since I'm sure there are
contingencies that I'm not taking into account.  For example, the real
root filesystem is mounted (readonly), and if that makes a problem
for resuming, how can we squeeze software_resume after the initrd and
before mounting the root disc?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
