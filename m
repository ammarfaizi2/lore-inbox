Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbRFUEzU>; Thu, 21 Jun 2001 00:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264846AbRFUEzK>; Thu, 21 Jun 2001 00:55:10 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:31559 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S264844AbRFUEy5>;
	Thu, 21 Jun 2001 00:54:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.4.5-ac16 -- Still getting unresolved gameport_register_port and gameport_unregister_port symbols in joystick drivers. 
In-Reply-To: Your message of "Wed, 20 Jun 2001 16:38:03 MST."
             <web-26144619@back1.mail.megapathdsl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Jun 2001 14:54:29 +1000
Message-ID: <8127.993099269@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001 16:38:03 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac16/kernel/drivers/char/joystick/cs461x.o
>depmod: 	gameport_register_port

Quick and dirty fix.

Index: 5.39/drivers/char/joystick/Config.in
--- 5.39/drivers/char/joystick/Config.in Wed, 20 Jun 2001 13:07:10 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.4 644)
+++ 5.39(w)/drivers/char/joystick/Config.in Thu, 21 Jun 2001 14:47:53 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.4 644)
@@ -6,7 +6,7 @@ mainmenu_option next_comment
 comment 'Joysticks'
 
 if [ "$CONFIG_INPUT" != "n" ]; then
-   tristate 'Game port support' CONFIG_INPUT_GAMEPORT
+   dep_tristate 'Game port support' CONFIG_INPUT_GAMEPORT $CONFIG_INPUT
       dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
       dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
       dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT

There are too many cross directory dependencies and undocumented
assumptions on input, gameport, joystick and sound options.  Vojtech,
we need a specification on how these should interact before we make any
more changes to the config code.  What should the dependencies be for
input, gameport, joysticks and gameport using soundcard really be?

