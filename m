Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129185AbRCHQLx>; Thu, 8 Mar 2001 11:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRCHQLn>; Thu, 8 Mar 2001 11:11:43 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129185AbRCHQL3>; Thu, 8 Mar 2001 11:11:29 -0500
Date: Thu, 8 Mar 2001 11:09:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Weinehall <tao@acc.umu.se>
cc: "Richard B. Johnson" <johnson@groveland.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3
In-Reply-To: <20010308164419.C18769@khan.acc.umu.se>
Message-ID: <Pine.LNX.3.95.1010308105749.311A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, David Weinehall wrote:

> On Mon, Mar 05, 2001 at 09:35:30PM -0500, Richard B. Johnson wrote:
> > 
> > Attempts to run linux-2.4.3-pre2 on chaos.analogic.com results
> > in **MASSIVE** file-system destruction. I have (had) all SCSI
> > disks, using the BusLogic controller.
> > 
> > There is something **MAJOR** going on BAD, BAD, BAD, even disks
> > that were not mounted got trashed.
> > 
> > This is (was) a 400MHz SMP machine with 256 Mb of RAM. I don't
> > know what else to say, since I have nothing to mount. I can
> > "get back" but it will take several days. I have to install a
> > minimum system then restore everything from tapes.
> > 
> > I   -- S T R O N G L Y -- suggest that nobody use this kernel with
> > a BusLogic SCSI controller until this problem is fixed.
> > 
> > This is being sent from another machine, not on the list (actually
> > from home where I am trying to see what happened -- I brought all
> > 4 of my disks home). It looks like some kind of a loop. I have
> > a pattern written throughout one of the disks.
> 
> Anything new on this? It sounds rather strange considering your
> unmounted disks got trashed too, so either it's a problem with the
> SCSI subsystem (or the driver; it might be a bug that got triggered
> by something else) or some sort of hardware failure.
> 
> What kind of pattern was repeated on the disk, by the way? Maybe this
> could shed some light unto what happened.
> 

Here is the pattern: Repeated at 0x1000 intervals. It looks like
the first page of the kernel, matched here at 0x00100000.

The "Unknown interrupt" text was a dead giveaway.


00100000 FC B8 18 00 00 00 8E D8 8E C0 8E E0 8E E8 66 09 ..............f.
00100010 DB 74 17 83 3D AC 53 25 00 00 74 26 0F 20 E0 0B .t..=.S%..t&. ..
00100020 05 AC 53 25 00 0F 22 E0 EB 18 BF 00 20 10 00 B8 ..S%.."..... ...
00100030 07 00 00 00 AB 05 00 10 00 00 81 FF 00 40 10 00 .............@..
00100040 75 F2 B8 00 10 10 00 0F 22 D8 0F 20 C0 0D 00 00 u.......".. ....
00100050 00 80 0F 22 C0 EB 00 B8 5E 00 10 C0 FF E0 0F B2 ..."....^.......
00100060 25 30 02 10 C0 66 09 DB 74 05 6A 00 9D EB 5C 31 %0...f..t.j...\1
00100070 C0 BF F0 E8 23 C0 B9 50 76 27 C0 29 F9 F3 AA E8 ....#..Pv'.)....
00100080 76 01 00 00 6A 00 9D BF 00 40 10 C0 B9 00 02 00 v...j....@......
00100090 00 FC F3 A5 31 C0 B9 00 02 00 00 F3 AB 8B 35 28 ....1.........5(
001000A0 42 10 C0 21 F6 75 18 66 81 3D 20 00 09 00 3F A3 B..!.u.f.= ...?.
001000B0 75 19 0F B7 35 22 00 09 00 81 C6 00 00 09 00 BF u...5"..........
001000C0 00 48 10 C0 B9 00 02 00 00 F3 A5 C7 05 88 2C 21 .H............,!
001000D0 C0 FF FF FF FF C7 05 80 2C 21 C0 03 00 00 00 9C ........,!......
001000E0 58 89 C1 35 00 00 04 00 50 9D 9C 58 31 C8 25 00 X..5....P..X1.%.
001000F0 00 04 00 74 79 C7 05 80 2C 21 C0 04 00 00 00 89 ...ty...,!......

00100100 C8 35 00 00 20 00 50 9D 9C 58 31 C8 51 9D 25 00 .5.. .P..X1.Q.%.
00100110 00 20 00 74 4A 31 C0 0F A2 A3 88 2C 21 C0 89 1D . .tJ1.....,!...
00100120 90 2C 21 C0 89 15 94 2C 21 C0 89 0D 98 2C 21 C0 .,!....,!....,!.
00100130 09 C0 74 2B B8 01 00 00 00 0F A2 88 C1 80 E4 0F ..t+............
00100140 88 25 80 2C 21 C0 24 F0 C0 E8 04 A2 82 2C 21 C0 .%.,!.$......,!.
00100150 80 E1 0F 88 0D 83 2C 21 C0 89 15 8C 2C 21 C0 0F ......,!....,!..
00100160 20 C0 25 11 00 00 80 0D 22 00 05 00 EB 0D 51 9D  .%.....".....Q.
00100170 0F 20 C0 25 11 00 00 80 83 C8 02 0F 22 C0 E8 4F . .%........"..O
00100180 00 00 00 FE 05 D1 01 10 C0 0F 01 15 7A 02 10 C0 ............z...
00100190 0F 01 1D 72 02 10 C0 EA 9E 01 10 C0 10 00 B8 18 ...r............
001001A0 00 00 00 8E D8 8E C0 8E E0 8E E8 B8 18 00 00 00 ................
001001B0 8E D0 31 C0 0F 00 D0 FC 8A 0D D1 01 10 C0 80 F9 ..1.............
001001C0 01 74 07 E8 78 B7 12 00 EB 05 E8 11 66 12 00 EB .t..x.......f...
001001D0 FE 02 C6 05 86 2C 21 C0 00 0F 06 DB E3 9B DF E0 .....,!.........
001001E0 3C 00 74 0C 0F 20 C0 83 F0 04 0F 22 C0 C3 89 F6 <.t.. ....."....
001001F0 C6 05 86 2C 21 C0 01 DB E4 C3 8D 15 50 02 10 C0 ...,!.......P...

00100200 B8 00 00 10 00 66 89 D0 66 BA 00 8E 8D 3D 00 A0 .....f..f....=..
00100210 23 C0 B9 00 01 00 00 89 07 89 57 04 83 C7 08 49 #.........W....I
00100220 75 F5 C3 8D B6 00 00 00 00 8D BC 27 00 00 00 00 u..........'....
00100230 00 54 FF D3 18 00 00 00 55 6E 6B 6E 6F 77 6E 20 .T......Unknown 
00100240 69 6E 74 65 72 72 75 70 74 0A 00 90 8D 74 26 00 interrupt....t&.
00100250 FC 50 51 52 06 1E B8 18 00 00 00 8E D8 8E C0 68 .PQR...........h
00100260 38 02 10 C0 E8 B7 67 01 00 58 1F 07 5A 59 58 CF 8.....g..X..ZYX.
00100270 00 00 FF 07 00 A0 23 C0 00 00 5F 04 80 11 21 C0 ......#..._...!.
00100280 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
00100290 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002A0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002C0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002D0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002E0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
001002F0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................


This get triggered if:

(1)	The machine is booted via initrd.
(2)	An attempt is made to use the RAM disk after it's booted.
(3)	A BusLogic controller.


Now, if I use /dev/ram1, instead of /dev/ram0 (1:1 instead of 1:0), the
problem doesn't show up. It appears as though change_root() leaves
something dangling so that a write to what used to be the root file-
system, results in some pointer/code/whatever corruption. Ultimately
this leads to unexpected SCSI writes.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


