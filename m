Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSGQNWG>; Wed, 17 Jul 2002 09:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGQNWG>; Wed, 17 Jul 2002 09:22:06 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:41665 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S313563AbSGQNWD>; Wed, 17 Jul 2002 09:22:03 -0400
Date: Wed, 17 Jul 2002 15:24:59 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: input subsystem config ?
Message-ID: <20020717132459.GF14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020716143415.GO7955@tahoe.alcove-fr> <20020717095618.GD14581@tahoe.alcove-fr> <20020717120135.A12452@ucw.cz> <20020717101001.GE14581@tahoe.alcove-fr> <20020717140804.B12529@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717140804.B12529@ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:08:04PM +0200, Vojtech Pavlik wrote:

> > i8042.c: 60 -> i8042 (command) [65]
> > i8042.c: 77 -> i8042 (parameter) [65]
> > i8042.c: d4 -> i8042 (command) [65]
> > i8042.c: f6 -> i8042 (parameter) [65]
> 
> This is the bug. :) It tries to talk to the mouse before enabling the
> mouse interface. I wonder how it could work ... probably many chipsets
> ignore the disable bit altogether.
> 
> Please try with the attached i8042.c.

I'm afraid it doesn't work either:
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
mice: PS/2 mouse device common for all mice
i8042.c: fa <- i8042 (flush, kbd) [0]
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 56 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [0]
i8042.c: 5a -> i8042 (parameter) [0]
i8042.c: a5 <- i8042 (return) [0]
i8042.c: a9 -> i8042 (command) [0]
i8042.c: 00 <- i8042 (return) [0]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 76 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 56 <- i8042 (return) [1]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 74 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 54 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 56 -> i8042 (parameter) [2]
i8042.c: d4 -> i8042 (command) [2]
i8042.c: f6 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [3]
i8042.c: 56 -> i8042 (parameter) [3]
i8042.c: 60 -> i8042 (command) [92]
i8042.c: 54 -> i8042 (parameter) [92]
i8042.c: 60 -> i8042 (command) [93]
i8042.c: 56 -> i8042 (parameter) [93]
i8042.c: d4 -> i8042 (command) [93]
i8042.c: f5 -> i8042 (parameter) [93]
i8042.c: 60 -> i8042 (command) [93]
i8042.c: 56 -> i8042 (parameter) [93]
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 54 -> i8042 (parameter) [182]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 44 -> i8042 (parameter) [182]
i8042.c: 60 -> i8042 (command) [182]
i8042.c: 45 -> i8042 (parameter) [182]
i8042.c: f6 -> i8042 (kbd-data) [182]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [185]
i8042.c: f2 -> i8042 (kbd-data) [185]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [187]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [193]
i8042.c: 60 -> i8042 (command) [194]
i8042.c: 44 -> i8042 (parameter) [194]
i8042.c: 60 -> i8042 (command) [194]
i8042.c: 45 -> i8042 (parameter) [194]
i8042.c: f5 -> i8042 (kbd-data) [194]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [197]
i8042.c: f2 -> i8042 (kbd-data) [197]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [200]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [205]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [210]
i8042.c: ea -> i8042 (kbd-data) [210]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [212]
i8042.c: f0 -> i8042 (kbd-data) [212]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [215]
i8042.c: 02 -> i8042 (kbd-data) [215]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [218]
i8042.c: f0 -> i8042 (kbd-data) [218]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [221]
i8042.c: 00 -> i8042 (kbd-data) [221]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [224]
i8042.c: 41 <- i8042 (interrupt, kbd, 1) [226]
input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
input.c: hotplug returned -2
input: AT Set 2 keyboard on isa0060/serio0
i8042.c: f8 -> i8042 (kbd-data) [229]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [232]
i8042.c: ed -> i8042 (kbd-data) [232]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [235]
i8042.c: 00 -> i8042 (kbd-data) [236]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [241]
i8042.c: f4 -> i8042 (kbd-data) [241]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [244]
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
...
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
