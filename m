Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSGGCXw>; Sat, 6 Jul 2002 22:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSGGCXw>; Sat, 6 Jul 2002 22:23:52 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:43505 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S314243AbSGGCXv>; Sat, 6 Jul 2002 22:23:51 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: James Simmons <jsimmons@transvirtual.com>, torvalds@transmeta.com
Subject: Re: [patch] Typo fixes in input code
Date: Sun, 7 Jul 2002 12:22:48 +1000
User-Agent: KMail/1.4.5
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <vojtech@twilight.ucw.cz>
References: <Pine.LNX.4.44.0207061047370.26054-100000@www.transvirtual.com>
In-Reply-To: <Pine.LNX.4.44.0207061047370.26054-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_0AXUFMZBNSYGBNY9JFPV"
Message-Id: <200207071222.48783.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_0AXUFMZBNSYGBNY9JFPV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sun, 7 Jul 2002 03:48, James Simmons wrote:
> You patch is right except for drivers/input/gameport/Config.help. That was
> right before your patch.
OK. I assumed that Config.in was the authoritative source, and Config.help 
should match. Looks like (based on the Makefile) that I probably should have 
changed it to be CONFIG_GAMEPORT_EMU10K1 in the Config.in. In fact, that 
driver won't ever be built with vanilla 2.5.25, with or without the previous 
patch

BK already has the previous change applied, so this in an incremental diff:

<bk text>
EMU10K1 build fix

Revert the CONFIG_INPUT_EMU10K1 change to drivers/input/gameport/Config.help, 
and change drivers/input/gameport/Config.in to use CONFIG_GAMEPORT_EMU10K1
</bk text> 

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_0AXUFMZBNSYGBNY9JFPV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="EMU10K1-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="EMU10K1-typo.patch"

diff -Naur -X dontdiff linux-2.5.25-inputtypos1/drivers/input/gameport/Config.help linux-2.5.25-inputtypos2/drivers/input/gameport/Config.help
--- linux-2.5.25-inputtypos1/drivers/input/gameport/Config.help	Sun Jul  7 12:19:47 2002
+++ linux-2.5.25-inputtypos2/drivers/input/gameport/Config.help	Sun Jul  7 12:18:56 2002
@@ -34,7 +34,7 @@
   The module will be called lightning.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
-CONFIG_INPUT_EMU10K1
+CONFIG_GAMEPORT_EMU10K1
   Say Y here if you have a SoundBlaster Live! or SoundBlaster
   Audigy card and want to use its gameport.
 
diff -Naur -X dontdiff linux-2.5.25-inputtypos1/drivers/input/gameport/Config.in linux-2.5.25-inputtypos2/drivers/input/gameport/Config.in
--- linux-2.5.25-inputtypos1/drivers/input/gameport/Config.in	Sat Jul  6 09:42:01 2002
+++ linux-2.5.25-inputtypos2/drivers/input/gameport/Config.in	Sun Jul  7 12:18:56 2002
@@ -13,7 +13,7 @@
 
 dep_tristate '  Classic ISA and PnP gameport support' CONFIG_GAMEPORT_NS558 $CONFIG_GAMEPORT
 dep_tristate '  PDPI Lightning 4 gamecard support' CONFIG_GAMEPORT_L4 $CONFIG_GAMEPORT
-dep_tristate '  SB Live and Audigy gameport support' CONFIG_INPUT_EMU10K1 $CONFIG_GAMEPORT
+dep_tristate '  SB Live and Audigy gameport support' CONFIG_GAMEPORT_EMU10K1 $CONFIG_GAMEPORT
 dep_tristate '  Aureal Vortex, Vortex 2 gameport support' CONFIG_GAMEPORT_VORTEX $CONFIG_GAMEPORT
 dep_tristate '  ForteMedia FM801 gameport support' CONFIG_GAMEPORT_FM801 $CONFIG_GAMEPORT
 dep_tristate '  Crystal SoundFusion gameport support' CONFIG_GAMEPORT_CS461x $CONFIG_GAMEPORT

--------------Boundary-00=_0AXUFMZBNSYGBNY9JFPV--

