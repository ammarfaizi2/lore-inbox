Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWB1BDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWB1BDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWB1BDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:03:22 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:19849 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751863AbWB1BDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:03:21 -0500
Message-ID: <4403A14D.4050303@comcast.net>
Date: Mon, 27 Feb 2006 20:03:09 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory compression (again). . help?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not quite sure what I'm doing or when I have time, but I'm looking
into writing in some hooks and a compression routine to manage
compressed memory.  I have the following considerations:

 - Compressed memory should become "Swap."  This means the kernel would
   report memory used for compressed storage as used swap.  At boot it
   would reflect 0K swap; when there are 1024KiB of pages compressed in
   memory, 1024KiB of additional "swap" is reported, all used.
 - I need to stop the kernel when it's about to swap.  This should be
   done when it's decided that either invalidating disk cache or
   swapping is the best course of action, and what to do with what.  At
   this point I'll have to be able to see what the kernel wants to swap
   out and tell it that it's taken care of.
 - I need to catch invalid pagefaults that look for swap, as well as the
   disk cache mechanism.  I'll be adding stuff to compress disk cache,
   so disk cache might need to be "swapped in" effectively.

Can anyone recommend what functions I should look at modifying?  I'm
planning on using Rodrigo Castro's WK4x4 or WKdm algorithms, as they
worked great in his proof of concept.  32KiB blocks will be used because
I got about a 40% reduction with those, and that was where I reached
asymptotic growth (larger blocks did not compress much more, smaller
blocks compressed much less).

Compressed memory is great for things like LiveCDs and huge database
servers, as well as just giving almost-but-not-quite free memory in general.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEA6FKhDd4aOud5P8RAnGyAJ9kFbdxA5+DroHFOZS7oM4uzYhN1gCfbVa+
rHPUYKjXjekcwLnHN+e12IE=
=K/bw
-----END PGP SIGNATURE-----

