Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSIDTRc>; Wed, 4 Sep 2002 15:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSIDTRc>; Wed, 4 Sep 2002 15:17:32 -0400
Received: from [64.6.248.2] ([64.6.248.2]:7304 "EHLO greenie.frogspace.net")
	by vger.kernel.org with ESMTP id <S315200AbSIDTRc>;
	Wed, 4 Sep 2002 15:17:32 -0400
Date: Wed, 4 Sep 2002 12:21:59 -0700 (PDT)
From: Peter <cogweb@cogweb.net>
X-X-Sender: cogweb@greenie.frogspace.net
To: linux-kernel@vger.kernel.org, <cpia@risc.uni-linz.ac.at>
cc: Peter.Pregler@risc.uni-linz.ac.at
Subject: 2.4.19-ac cpia AWOL error
Message-ID: <Pine.LNX.4.44.0209041054350.21967-100000@greenie.frogspace.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just installed CPiA with the 2.4.19-ac4 kernel, and it's working great. 
However, when I run xawtv, I get these errors every few seconds:

kernel: usb-uhci.c: interrupt, status 2, frame# 1575
kernel: *_comp parameters have gone AWOL (2/0/0/0) - reseting them

The same errors were posted to the cpia list in May of last year,
http://mailman.risc.uni-linz.ac.at/pipermail/cpia/2001-May/001056.html 
and wrt other topics occasionally on lkml.

The origin of this error message is a patch for a color balance problem:
http://mailman.risc.uni-linz.ac.at/pipermail/cpia/2000-March/000559.html

This is the patch:
http://mailman.risc.uni-linz.ac.at/pipermail/cpia/2000-March/000570.html

The patch introduced the error message -- "By the way - I left a warning
in place in the patch. If the patch is working correctly, then the warning
should *never* be printed out."

This warning is the one I'm seeing:

+    printk (KERN_WARNING "*_comp parameters have gone AWOL (%d/%d/%d/%d) 
- reseting them\n",

It looks like this color balancing patch, introduced into the driver in
March 2000 (cf. http://webcam.sourceforge.net), is not working and is
generating an otherwise irrelevant error message to that effect.

I'll leave it to Peter Pregler and the other cpia developers to determine
whether the color balancing really is a problem or not -- I can't say I
see one. But the error message is clearly unnecessary and should be
removed.

Cheers,
Peter


I compiled usb-uhci into the kernel, and run these modules:

Module                  Size  Used by
cpia_usb                4800   0 (autoclean) (unused)
cpia                   50832   1 [cpia_usb]
videodev                6176   2 [cpia]

The device is an Ezonics EZCam and the picture looks great.


