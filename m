Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSFKOgg>; Tue, 11 Jun 2002 10:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSFKOgg>; Tue, 11 Jun 2002 10:36:36 -0400
Received: from drtalus.aoe.vt.edu ([128.173.167.12]:59909 "EHLO
	drtalus.aoe.vt.edu") by vger.kernel.org with ESMTP
	id <S317101AbSFKOge>; Tue, 11 Jun 2002 10:36:34 -0400
Message-Id: <200206111436.g5BEa4Z17577@drtalus.aoe.vt.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x kernels hang before uncompressing
Date: Tue, 11 Jun 2002 10:36:04 -0400
From: Cengiz Akinli <cengiz@drtalus.aoe.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,

   We have a Tri-M PC-104 system with a Cyrix ZF486 processor that (in
addition to being painfully slow building kernels) refuses to boot any
2.4.x kernels.  It has a M-Systems Disk-On-Chip 2000 (which ironically,
I got to work just fine with the 2.2.x kernel that I had to patch, but
NOT with the 2.4 kernel that comes with a driver), but I don't think that's
the problem, because the 2.4.x kernel is not even uncompressing, to say
nothing of booting and trying to mount the root fs.

  It DOES appear to finish loading, because it outputs a linefeed after
the line of dots in 'Loading linux....'

  I have found VERY few instances of people running into this problem
elsewhere even after looking high and low on the 'net, including digging
through this list's archives.  The one candidate situation I found was
one where the system did exactly what mine was doing but only when the
keyboard was unplugged.  Mine doesn't work with or without the keyboard.

  The answer to that post was by Chris Noe <stiker@northlink.com>
around 12/1999 and reads:
>I have a feeling that its the empty_8042 routine in arch/i386/boot/setup.S
>that's causing you problems.... without a keyboard attached, some
>controllers will hang there, sadly. If you feel brave, take a look in
>setup.S around lines 598 (where we enable a20) and 783 (the empty_8042
>routine itself)  and see if you can get rid of those calls to empty_8042
>or otherwise screw around in there so that it doesn't wait forever to
>empty the controller's buffers.

  The lilo used to install the boot sector on this Disk On Chip is
a custom-patched one provided by the vendor.  It works fine on 2.2.x
kernels.  Should I suspect it?

  I've looked high-and-low, I've tried everything I can think of,
including compiling kernels with absolutley nothing in them, just trying
to get them to decompress.  No luck.

  The hardware I need to be able to use is a multi-port USB-to-serial
convertor.  And this is only directly supported in 2.4.x kernels.
If I can't get the 2.4.x kernels to boot, then I'll have to try to
hack the support for that devices into the 2.2.x kernel, which I
really don't want to attempt.

  Any help anyone can offer would be appreciated.

Sincerely,
Cengiz Akinli

