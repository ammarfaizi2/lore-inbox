Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBHGSz>; Thu, 8 Feb 2001 01:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbRBHGSp>; Thu, 8 Feb 2001 01:18:45 -0500
Received: from lochinvar.ece.neu.edu ([129.10.60.161]:31184 "EHLO
	lochinvar.ece.neu.edu") by vger.kernel.org with ESMTP
	id <S129281AbRBHGS0> convert rfc822-to-8bit; Thu, 8 Feb 2001 01:18:26 -0500
Date: Thu, 8 Feb 2001 01:18:10 -0500 (EST)
From: Mauricio Martinez <mmartine@ECE.NEU.EDU>
To: linux-kernel@vger.kernel.org
Subject: Module usage count - sound
Message-ID: <Pine.GSO.4.21.0102080109220.24634-100000@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.4.1

I have sound support, OSS and my soundcard (sb) configured as modules

If I just play a sound on /dev/dsp, I get the following after the program
exits:

mixcoac:~> cat /proc/modules
sb                      2000   0 (autoclean)
sb_lib                 33504   0 (autoclean) [sb]
uart401                 6224   0 (autoclean) [sb_lib]
sound                  55280   0 (autoclean) [sb_lib uart401]
soundcore               3664   5 (autoclean) [sb_lib sound]

This means that the sound modules are not longer used and thus,
removable. Everything OK so far.

The problem occurs when /dev/dsp is blocked by the above described
process, and another process (say SOX, XMMS and such) attempts to write
to the same device. After the two of them finish, the usage count is not
reset for some reason, like

mixcoac:~> cat /proc/modules
sb                      2000   1 (autoclean)
sb_lib                 33504   0 (autoclean) [sb]
uart401                 6224   0 (autoclean) [sb_lib]
sound                  55280   0 (autoclean) [sb_lib uart401]
soundcore               3664   5 (autoclean) [sb_lib sound]

So, the module cannot be removed and stays loaded forever.

This problem is 100% reproductable.

What's wrong? any ideas?

---------------------------------------------------------------------------
Mauricio Martínez      Northeastern University    mmartine@ece.neu.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
