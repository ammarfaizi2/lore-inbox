Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVCHAdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVCHAdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVCHAWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:22:54 -0500
Received: from exosec.net1.nerim.net ([62.212.114.195]:19368 "EHLO
	mail-out1.exosec.net") by vger.kernel.org with ESMTP
	id S261873AbVCHASU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:18:20 -0500
Date: Tue, 8 Mar 2005 01:18:15 +0100
From: Willy Tarreau <wtarreau@exosec.fr>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.29-hf4
Message-ID: <20050308001815.GB9125@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth release of the hotfix tree for Linux 2.4.29.

Few minor changes, mostly a resync with -bk. Sparc64 users of hf3 are
encouraged to update because of a typo in sys32_semtimedop(). Most
other patches are only very low-risk fixes in a few drivers. Full
changelog below. Get it in the usual place :

    http://linux.exosec.net/kernel/2.4-hf/

Cheers,
Willy

PS: I'm starting to see external testers, which is encouraging.


Changelog From 2.4.29-hf3 to 2.4.29-hf4 (semi-automated)
---------------------------------------
'+' = added ; '-' = removed

Only minor fixes this time again, several of which affect drivers but are as trivial
as timeouts enlargements. 504 lines removed, 714 lines added.

Please note : The aic7xxx patch is known to cause Justin Gibbs' AIC7XXX driver to
reject when applied because it already contains the fix. In this case, simply
rebuild the whole patch without the former.


- sparc64-32bit-compat-bugs-1                                 (David S. Miller)
+ sparc64-32bit-compat-bugs-2                                 (David S. Miller)
 
  Fixed a typo found in the original patch which affects semtimedop().
  ACKed by David, should reach mainline ASAP.
   
+ genesys-usb-workarounds-1                                      (Pete Zaitcev)

  Disk enclosures with Genesys Logics chipset require additional delays, or
  commands are not processed. Also, their maximum transfer size is limited.
  Patch by Martin Strigl.

+ libata-missing-hook-oops-1                                      (Jeff Garzik)

  Advanced SATA drivers should not (and cannot) use the basic PCI IDE hooks for
  checking the Status and Error registers, as these registers are either in
  non-standard locations, or simply don't exist. In the error handling path,
  libata was unconditionally calling some PCI IDE hardware bitbanging
  functions, which would cause an oops in the AHCI driver and any other
  advanced libata driver.

+ synclinkmp-register-access-typo-1                              (Paul Fulghum)

  Fix typo to correctly access rx ready control (RRC) register instead of the
  tx ready control (TRC0) register.

+ aic7xxx-do-not-reset-on-pause-1                                 (Matt Domsch)

  Patch below taken from RHEL3 Update 4 kernel 2.4.21-27.EL, fixes a bug in
  the aic79xx and aic7xxx drivers, where upon trying to pause the controller
  chip, it is accidentally hard-reset.  This causes PCI Parity errors to appear
  on Dell PowerEdge 4600 servers as the inb() immediately after accidental
  reset receives corrupted data. Patch was submitted by Justin Gibbs many moons
  ago, but never applied to mainline 2.4. It's in mainline 2.6.
  
+ fix-swapoff-after-recreating-device-1                        (Solar Designer)

  [PATCH] Fix for swapoff after re-creating device files
  If device is recreated the current dentry-only comparison in sys_swapoff()
  might have problems.

+ sd-fix-partition-count-1                                            (Soo Lee)

  When a scsi disk is removed other scsi disk with biggest minor # disapears
  in /proc/partition at the same time. sd.c decreases nr_real on disk removal
  but because nr_real is not real # of devices but max # of devices of a major
  #, it doesn't need to be changed on disk add/remove. 2.6 has little different
  structure but it does like this.

+ af_unix-fix-siocinq-for-stream-1                            (David S. Miller)

  [AF_UNIX]: Fix SIOCINQ for STREAM.
  We should report the total bytes in the whole receive queue, not just the
  first packet, in these cases. Reported by Uwe Bonnes.

+ scsi-tapes-return-enomem-1                                  (Marcelo Tosatti)
+ scsi-tapes-allow-lseek-1                                    (Marcelo Tosatti)

  Allow lseek on SCSI tapes again. Recently broken by a security fix.
  
-END-
[B
