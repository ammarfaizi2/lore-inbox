Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319285AbSHNTMG>; Wed, 14 Aug 2002 15:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319286AbSHNTMG>; Wed, 14 Aug 2002 15:12:06 -0400
Received: from p0465.as-l042.contactel.cz ([194.108.238.211]:7296 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S319285AbSHNTME>;
	Wed, 14 Aug 2002 15:12:04 -0400
Date: Wed, 14 Aug 2002 21:16:44 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Fwd: [BKPATCH] matroxfb is broken by recent fbdev updates
Message-ID: <20020814191644.GC37217@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  if you want working matroxfb in the latest 2.5.31-bk tree, please
either pull from the bk://matroxfb.bkbits.net/linux-2.5, or
download patch from 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/linux-2.5.31bk-matroxfb.gz.
							Petr Vandrovec
							vandrove@vc.cvut.cz

----- Forwarded message from Petr Vandrovec <vandrove@vc.cvut.cz> -----

Date: Wed, 14 Aug 2002 21:13:32 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Subject: [BKPATCH] matroxfb is broken by recent fbdev updates

Hi Linus,
  please either do pull by using 
	
		bk pull bk://matroxfb.bkbits.net/linux-2.5

or apply bk-patch below. Matroxfb (and couple of other drivers) is broken
by recent fbdev update from JSimmons.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.522, 2002-08-14 17:53:32+02:00, vandrove@vc.cvut.cz
  Update matroxfb to current fbdev API.

ChangeSet@1.521, 2002-08-14 16:38:36+02:00, vandrove@vc.cvut.cz
  Set system PLL vcomax correctly in matroxfb. Discovered by Dirk Uffmann.

ChangeSet@1.520, 2002-08-14 16:38:04+02:00, vandrove@vc.cvut.cz
  matroxfb: Do not store results of bitwise AND directly in variables which are
  treated as a booleans. Comparsion does not work correctly on them. 

ChangeSet@1.519, 2002-08-14 16:37:23+02:00, vandrove@vc.cvut.cz
  Add support for MGA-TVO-B into matroxfb. By Mike Pieper.

ChangeSet@1.518, 2002-08-14 16:36:45+02:00, vandrove@vc.cvut.cz
  Return ENOTTY instead of EINVAL for unknown ioctl ops in matroxfb.

ChangeSet@1.517, 2002-08-14 16:36:06+02:00, vandrove@vc.cvut.cz
  Use sizeof(*var) instead of sizeof(struct xxx) in matroxfb.

ChangeSet@1.516, 2002-08-14 16:35:29+02:00, vandrove@vc.cvut.cz
  Remove currcon field from private fb_info in matroxfb. It was moved to the
  generic layer long ago.

ChangeSet@1.515, 2002-08-14 16:34:44+02:00, vandrove@vc.cvut.cz
  Make debug printouts in matroxfb G400 TV-out disabled by default.
  OUTPUT_MODE are values, not a bitmap, so use compare instead of bitwise AND.

ChangeSet@1.514, 2002-08-14 16:32:33+02:00, vandrove@vc.cvut.cz
  Add TV-Out support for Matrox G450/G550. Due to the hardware only secondary
  CRTC can be used as a source for TV output.

ChangeSet@1.513, 2002-08-14 16:30:01+02:00, vandrove@vc.cvut.cz
  matroxfb DVI updates:
  Handle DVI output on G450/G550.
  Powerdown unused portions of G450/G550 DAC.
  Split G450/G550 DAC from older DAC1064 handling.
  Modify PLL setting when both CRTCs use same pixel clocks.

ChangeSet@1.512, 2002-08-14 16:24:08+02:00, vandrove@vc.cvut.cz
  Initialize Matrox G100 and G400 hardware with values read from BIOS instead of
  with failsafe settings discovered in the past.
  Fixes corrupted screen display on some G100.

ChangeSet@1.511, 2002-08-14 16:23:10+02:00, vandrove@vc.cvut.cz
  Use container_of instead of simple typecast when we convert pointers from
  pointer to fb_info to pointers to matrox_fb_info.

ChangeSet@1.510, 2002-08-14 16:21:59+02:00, vandrove@vc.cvut.cz
  Store pointer to matroxfb specific fb information instead of universal
  fb_info* pointer for secondary head. Saves some typecasts.

ChangeSet@1.509, 2002-08-14 16:20:37+02:00, vandrove@vc.cvut.cz
  Use arrays for holding Matrox output drivers, it is nicer and more extensible
  than current solution with per-CRTC bitmaps.

ChangeSet@1.508, 2002-08-14 16:19:37+02:00, vandrove@vc.cvut.cz
  Simplify rules for writting secondary output drivers to matroxfb.
  Update some initializations to use C99 initializers.

ChangeSet@1.507, 2002-08-14 16:11:17+02:00, vandrove@vc.cvut.cz
  matroxfb: Find appropriate setting for specified color depth by looking through
  table instead of using if-else branches in code. Source is cleaner, and generated
  code is smaller with this change. By Denis Zaitsev <zzz@cd-club.ru>

ChangeSet@1.506, 2002-08-14 16:08:09+02:00, vandrove@vc.cvut.cz
  Remove structure holding state of secondary output in the matroxfb driver.
  We do not have any state stored here.

ChangeSet@1.505, 2002-08-14 16:04:20+02:00, vandrove@vc.cvut.cz
  Make secondary output support mandatory for Matrox G450/G550.

ChangeSet@1.504, 2002-08-14 16:01:28+02:00, vandrove@vc.cvut.cz
  Support secondary head DDC on G450/G550.
  Simplify i2c-matroxfb code.


 Config.help               |   58 ++--
 Config.in                 |    9 
 matrox/Makefile           |    6 
 matrox/g450_pll.c         |   85 +++---
 matrox/g450_pll.h         |    2 
 matrox/matroxfb_DAC1064.c |  332 +++++++++++++++++--------
 matrox/matroxfb_DAC1064.h |    4 
 matrox/matroxfb_Ti3026.c  |   22 +
 matrox/matroxfb_accel.c   |   34 +-
 matrox/matroxfb_accel.h   |    2 
 matrox/matroxfb_base.c    |  590 ++++++++++++++++++++++------------------------
 matrox/matroxfb_base.h    |   55 ++--
 matrox/matroxfb_crtc2.c   |  381 ++++++++++++++++-------------
 matrox/matroxfb_crtc2.h   |    3 
 matrox/matroxfb_g450.c    |  467 ++++++++++++++++++++++++++++--------
 matrox/matroxfb_g450.h    |   14 -
 matrox/matroxfb_maven.c   |  123 ++++-----
 matrox/matroxfb_misc.c    |   14 -
 18 files changed, 1331 insertions(+), 870 deletions(-)

