Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSHGWX0>; Wed, 7 Aug 2002 18:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSHGWX0>; Wed, 7 Aug 2002 18:23:26 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:7552 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S314078AbSHGWXY>;
	Wed, 7 Aug 2002 18:23:24 -0400
Date: Thu, 8 Aug 2002 00:26:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: FYI: [BK PATCH] matroxfb update: G450/G550 DVI and TV support
Message-ID: <20020807222654.GA3767@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,
  I just sent changeset below to the Linus. If you are using
my patches for TV-Out from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest,
please note that V4L2 support for setting brightness/contrast and other
features is NOT part of this patch. I'll send it to Linus after V4L2
interface finds its way into the 2.5 kernel.

  And also, as you may guess, driver is not ported to the new fbdev API.

  Patch and bkpatch were removed from this copy of message - it is
129KB file. You can download it from 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/bkpatch-for-linus-2.5.30,
or you can look at http://matroxfb.bkbits.net, or you can pull from
bk://matroxfb.bkbits.net/linux-2.5 or ... It applies cleanly to the currently
available 2.5 tree.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz

----- Forwarded message from Petr Vandrovec <vandrove@vc.cvut.cz> -----

Date: Thu, 8 Aug 2002 00:16:52 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Subject: [BK PATCH] matroxfb update: G450/G550 DVI and TV support

Linus,
  please apply changesets below. It adds DVI and TVOut functionality to
the matroxfb. Without proper DVI support matroxfb does not work with
currently sold G550.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
You can also do

     bk pull bk://matroxfb.bkbits.net/linux-2.5

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

===================================================================


ChangeSet@1.486, 2002-08-07 23:08:40+02:00, vandrove@vc.cvut.cz
  Set system PLL vcomax correctly in matroxfb. Discovered by Dirk Uffmann.

ChangeSet@1.485, 2002-08-07 22:56:59+02:00, vandrove@vc.cvut.cz
  matroxfb: Do not store results of bitwise AND directly in variables which are 
  treated as a booleans. Comparsion does not work correctly on them. 

ChangeSet@1.484, 2002-08-07 22:48:09+02:00, vandrove@vc.cvut.cz
  Add support for MGA-TVO-B into matroxfb. By Mike Pieper.

ChangeSet@1.483, 2002-08-07 22:17:53+02:00, vandrove@vc.cvut.cz
  Return ENOTTY instead of EINVAL for unknown ioctl ops in matroxfb.

ChangeSet@1.482, 2002-08-07 22:13:00+02:00, vandrove@vc.cvut.cz
  Use sizeof(*var) instead of sizeof(struct xxx) in matroxfb.

ChangeSet@1.481, 2002-08-07 22:07:39+02:00, vandrove@vc.cvut.cz
  Remove currcon field from private fb_info in matroxfb. It was moved to the generic
  layer long ago.

ChangeSet@1.480, 2002-08-07 21:55:40+02:00, vandrove@vc.cvut.cz
  Make debug printouts in matroxfb G400 TV-out disabled by default.
  OUTPUT_MODE are values, not a bitmap, so use compare instead of bitwise AND.

ChangeSet@1.479, 2002-08-07 21:46:46+02:00, vandrove@vc.cvut.cz
  Add TV-Out support for Matrox G450/G550. Due to the hardware only secondary CRTC
  can be used as a source for TV output.

ChangeSet@1.478, 2002-08-07 20:34:38+02:00, vandrove@vc.cvut.cz
  Handle DVI output on G450/G550.
  Powerdown unused portions of G450/G550 DAC.
  Split G450/G550 DAC from older DAC1064 handling.
  Modify PLL setting when both CRTCs use same pixel clocks.

ChangeSet@1.477, 2002-08-07 19:49:54+02:00, vandrove@vc.cvut.cz
  Initialize Matrox G100 and G400 hardware with values read from BIOS instead of
  with failsafe settings discovered in the past.
  Fixes corrupted screen display on some G100.

ChangeSet@1.476, 2002-08-07 19:31:42+02:00, vandrove@vc.cvut.cz
  Use container_of instead of simple typecast when we convert pointers from pointer
  to fb_info to pointers to matrox_fb_info.

ChangeSet@1.475, 2002-08-07 19:15:08+02:00, vandrove@vc.cvut.cz
  Store pointer to matroxfb specific fb information instead of universal fb_info*
  pointer for secondary head. Saves some typecasts.

ChangeSet@1.474, 2002-08-07 19:06:50+02:00, vandrove@vc.cvut.cz
  Use arrays for holding Matrox output drivers, it is nicer and more extensible
  than current solution with per-CRTC bitmaps.

ChangeSet@1.473, 2002-08-07 01:24:20+02:00, vandrove@vc.cvut.cz
  Simplify rules for writting secondary output drivers to matroxfb.
  Update some initializations to use C99 initializers.

ChangeSet@1.472, 2002-08-07 00:33:35+02:00, vandrove@vc.cvut.cz
  Verify validity of color depth passed to matroxfb by looking through table instead of using ifelseif... code.

ChangeSet@1.471, 2002-08-07 00:21:32+02:00, vandrove@vc.cvut.cz
  Merge secondary output state structure to main in matroxfb driver.

ChangeSet@1.470, 2002-08-06 23:58:36+02:00, vandrove@vc.cvut.cz
  Make secondary output support mandatory for Matrox G450/G550.

ChangeSet@1.469, 2002-08-06 22:52:03+02:00, vandrove@vc.cvut.cz
  Support secondary head DDC on G450/G550.
  Simplify i2c-matroxfb code.


 Config.help               |   58 ++---
 Config.in                 |    9 
 matrox/Makefile           |    6 
 matrox/g450_pll.c         |   85 ++++----
 matrox/g450_pll.h         |    2 
 matrox/matroxfb_DAC1064.c |  302 ++++++++++++++++++++---------
 matrox/matroxfb_DAC1064.h |    4 
 matrox/matroxfb_Ti3026.c  |   14 +
 matrox/matroxfb_base.c    |  474 ++++++++++++++++++++++++----------------------
 matrox/matroxfb_base.h    |   51 +++-
 matrox/matroxfb_crtc2.c   |  279 +++++++++++++++++----------
 matrox/matroxfb_crtc2.h   |    3 
 matrox/matroxfb_g450.c    |  467 +++++++++++++++++++++++++++++++++++----------
 matrox/matroxfb_g450.h    |   14 -
 matrox/matroxfb_maven.c   |  123 +++++------
 matrox/matroxfb_misc.c    |    6 
 16 files changed, 1208 insertions(+), 689 deletions(-)


