Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267859AbTCFHHg>; Thu, 6 Mar 2003 02:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267870AbTCFHHg>; Thu, 6 Mar 2003 02:07:36 -0500
Received: from dsl-212-144-227-068.arcor-ip.net ([212.144.227.68]:63360 "EHLO
	VikingPC.home") by vger.kernel.org with ESMTP id <S267859AbTCFHHd> convert rfc822-to-8bit;
	Thu, 6 Mar 2003 02:07:33 -0500
Date: Thu, 6 Mar 2003 08:18:04 +0100
From: Corvus Corax <corvusvcorax@gemia.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux vs Windows temperature anomaly
Message-Id: <20030306081804.4717d1c4.corvusvcorax@gemia.de>
In-Reply-To: <200303061038.44872.kernel@kolivas.org>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
	<p05210507ba8c20241329@[10.2.0.101]>
	<3E66842F.9020000@WirelessNetworksInc.com>
	<200303061038.44872.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 6 Mar 2003 10:38:44 +1100
schrieb Con Kolivas <kernel@kolivas.org>:

> 
> That doesn't make sense. His post said the temperature was 20 degrees lower 
> when it failed.
> 
> Con

I think it does,

look at this:

                                                   RAM
  ._____________________.
 _|| | | | | | | | | | ||_.                     ._/| ._/|
/ ||___________________|| |~\                   ||/| ||/|
| |O       _____       O| |~\\                 /||/| ||/|
| |     .-°| | |°-.     | |\\\\               //|| | || |
| |    / \ |~| | / \    | |\\\\\             //=|| |=|| |
| |   /| |\| |~|/| |\   | |\\\\.________.   ///=||/|=||/|
| |  * | | \_._/ |~| *  | |\===|        |==///==||/|=||/|
| |  |~|~| /CPU\ ~ | |  | |====| north  |==///==|| |=|| |
| |  | | |~\_ _/ | | |  | |====| bridge |=======|| |=|| |
| |  * | | / ° \ | |~*  | |/===| (MEM ) |=======||/|=||/|
| |   \| |/| |~|\|~|/   | |//==| (CTRL) |==\\\==||/|=||/|
| |    \ / |~| | \ /    | |////°~~~~~~~~°==\\\==|| |=|| |
| |     °-.|_|_|.-°     | |///// ||||||     \\\=|| |=|| |
| |O                   O| |////  ||||||      \\=||/|=||/|
| |~~~~~~~~~~~~~~~~~~~~~| |_//   ||||||       \\||/| ||/|
°~|| | | | | | | | | | ||~°_/    ||||||        \|| | || |
  °~~~~~~~~~~~~~~~~~~~~~°        ||||||         ||/  ||/
         CPU TEMP |              ||||||         |_|  |_|
                | | voltage      ||||||
                | |||            ||||||
                | |||          .________.
     Mainboard  | |||          |        |
      TEMP      .,,,,,,. data  | south  |
         O      |      |=======| bridge |
         \\_____°''''''°       | (BUS ) |
          °~~~~~~°             | (CTRL) |
                TEMP &         °~~~~~~~~°
             VOLTAGE ctrl     ////|||\\\\\
               chip            PCI & other BUS


the sensor for the system temperature (somewhere on the board) is connected to a driver chip (usually on the i2c bus)
like the w83781d (on my  board)

if something now causes the (often badly cooled) bridge to get hot (by more load between some periphery and the RAM for example)
,  the system temperature doesnt necessary have to increase.

if the bridge has only a heatsink, its temperature is somewhat like
(system TEMP)+ ( produced heatper time /  heat given to the air by heatsink per time )
where the heatsinks capacity is dependent on the delta temperature, too, gets complicated ;)

in short, the chips hotter than the rest of the system and if it has high load it gets even hotter,
but its temp is still dependant on the main system TEMP. ;)

blahrgh forget what i talk, watch the ASCII art, and imagine the effect of much data running between
BUS and RAM ;-) (or BUS and BUS if north and southbridge are on the same chip)

CvC

