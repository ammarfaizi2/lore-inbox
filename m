Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUBLPF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUBLPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:05:27 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:18356 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266461AbUBLPFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:05:14 -0500
Date: Thu, 12 Feb 2004 09:57:06 -0500
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: [BKPATCH] Fix for "Badness in kobject_get" (affected ieee1394)
Message-ID: <20040212145706.GB639@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have only affected ieee1394 because it uses
bus_for_each_dev in a particular (although correct) way.

Linux/Andrew/Greg, if you want to pull this from my repo, I can email
you the bk url privately.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1634, 2004-02-12 09:51:06-05:00, bcollins@debian.org
  [DRV/BASE]: Put checks in bus_for_each_{dev,drv} to make sure we don't go past the end of the list.


 bus.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)


diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Thu Feb 12 09:54:43 2004
+++ b/drivers/base/bus.c	Thu Feb 12 09:54:43 2004
@@ -168,7 +168,13 @@
 
 	down_read(&bus->subsys.rwsem);
 	list_for_each(entry,head) {
-		struct device * dev = get_device(to_dev(entry));
+		struct device *dev;
+
+		/* End of list */
+		if (entry == &bus->devices.list)
+			break;
+
+		dev = get_device(to_dev(entry));
 		error = fn(dev,data);
 		put_device(dev);
 		if (error)
@@ -212,7 +218,13 @@
 
 	down_read(&bus->subsys.rwsem);
 	list_for_each(entry,head) {
-		struct device_driver * drv = get_driver(to_drv(entry));
+		struct device_driver *drv;
+
+		/* End of list */
+		if (entry == &bus->drivers.list)
+			break;
+
+		drv = get_driver(to_drv(entry));
 		error = fn(drv,data);
 		put_driver(drv);
 		if(error)

===================================================================


This BitKeeper patch contains the following changesets:
1.1634
## Wrapped with gzip_uu ##


M'XL( +.3*T   [64;6O;,!#'7UN?XJ"PK=UB2Y9DQRXI?4C9Q@8+*=V;;03%
M5N(0QRJ2G+;,^^Z38YJN-!MTM'Y \OGOXW=W?[P'ET;JU)MFJBP7E4%[\$$9
MFWJYG"Y$Y2L]=Z&Q4BX4U$8'1F?!4NI*EH'3US>]T(^0DXR$S0I82VU2C_AT
M&[&W5S+UQN?O+S^?C!$:#."L$-5<7D@+@P&R2J]%F9MC88M25;[5HC(K:86?
MJ56SE38AQJ$[.8DIYE%#(LSB)B,Y(8(1F>.0]2-VGZU0*^DKDY=M 0_3,!P2
M3!*2T*2A<<(C- 3BDX@RP"S 84!"P$G*28JC'N8IQG#7G./[IL!; CV,3N%Y
M"SA#&7P;CK\&IR<7YS]2&-46LD)F2P.+"J:UF<R4GDB1%9.?N5R_R_7ZET. 
ME5A*,+66<"TA5]5K"W,%5\)8L(4$6>6@9IMMN3#61Y^ ]BF+T>A^&JCWQ ,A
M+# Z@I5RA.7Q7,I*^%?Y3=?WRM6<ZT5KB& JC P<O)]U;> A"XF[>1/Q,.8-
MS?*$4R[Z2<SE+":[&OZ79.TT0\)81&A#,8WZ&XL]UK9>>W[0NY1;I^U.1'%"
M,>$\H=P].@=L+,?I \.Q*"7TGX9CT M?Q'$OZ++-2+Y 3U]O+N>:T8[I_(?W
MAL3YA*"/[1(CSS-6UYD%A[O()!RX]1!]=_'@ ,X[KI8)#@(76\S@C:RLOG6N
M@%>.H'?4?6?\5K3O)-Y42['L4KAW,("YM)-.]<:J=M>EV-\_1,.0\):E71ZQ
L3+IR'9)^(E+7IMU(>HNT46V0]!](V_]O-]=Z->"",=$G&/T&#+NI(_,%    
 

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
