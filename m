Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTDPRuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTDPRuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:50:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:62946 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264514AbTDPRuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:50:50 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 16 Apr 2003 20:02:38 +0200 (MEST)
Message-Id: <UTC200304161802.h3GI2ch26701.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] kill ide-geometry.c, fix boot problems
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From alan@lxorguk.ukuu.org.uk  Wed Apr 16 18:26:31 2003

    On Mer, 2003-04-16 at 16:16, Andries.Brouwer@cwi.nl wrote:
    > All traces of ide_xlate_1024 have been removed.
    > Few people need it, and sometimes it was directly
    > harmful. (And it is dead code in 2.5.recent.)
    > There are now boot options "remap" and "remap63"
    > for people with EZD or DM.

    There are lots of people with remap/remap63 needs. This should
    be automated as it was before or it will be a nightmare.
    You are desperate to remove the ide_xlate stuff but you can't
    do that without providing equivalent automatic functionality,
    either thats in base or that the vendors all just merge anyway.

Ha, Alan - what a choice of words. "Nightmare". "Desperate".
It is not that bad.

About this particular patch: what is removed is dead code,
so your complaint is directed against some earlier patch
(maybe 2.5.30 or so). At that time we exchanged a letter or two
and left it at that.

This xlate stuff consists of two halves: geometry stuff and
remapping stuff. Both must die. From the point of view of a
vendor, geometry stuff is uninteresting - it is not used anywhere.
The remapping stuff has some interest, but the interest is really
small, and the vendor does its clients a definite disservice by
automatically assuming that a client wants these strange constructions.

Especially when the disk is to be a Linux-only disk it is very
unlikely that a client should want a disk manager.
I have guided many a user in getting rid of DM.

It is good that this semi-incorrect policy disappears from the kernel.
Of course we do not want to lose power. After 2.5.30 I said: as soon
as somebody needs it, I'll add a boot option. It happened today.

Now you are a vendor and want to do things automatically.
Three possibilities:

(i) Add an ioctl to do the remap at runtime
(I can also add it if you prefer) - only a few lines.
Now the RedHat installer can do the remap in case it detects
a disk manager. That is nice, because that means that in case of
a whole-disk install it could ask the user whether she wants to
preserve this animal. Probably she doesnt.

(ii) Do partition reading in initial userspace.
Now you are free to do what you want. It is userspace.

(iii) Revert some patches.

I get the impression that you prefer (iii). I prefer (ii).
Most realistic may be (i).

Andries
