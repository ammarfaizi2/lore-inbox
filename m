Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSJCM2u>; Thu, 3 Oct 2002 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbSJCM2u>; Thu, 3 Oct 2002 08:28:50 -0400
Received: from 62-190-218-74.pdu.pipex.net ([62.190.218.74]:772 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263270AbSJCM2q>; Thu, 3 Oct 2002 08:28:46 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031242.g93Cg3Uh000144@darkstar.example.net>
Subject: Re: 2.5.40: AT keyboard input problem
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Thu, 3 Oct 2002 13:42:02 +0100 (BST)
Cc: tori@ringstrom.mine.nu, linux-kernel@vger.kernel.org
In-Reply-To: <20021003133157.A38397@ucw.cz> from "Vojtech Pavlik" at Oct 03, 2002 01:31:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, Oct 03, 2002 at 12:34:15PM +0100, jbradford@dial.pipex.com wrote:
> > > On Thu, Oct 03, 2002 at 11:14:02AM +0100, jbradford@dial.pipex.com wrote:
> > > > > 
> > > > > On Thu, Oct 03, 2002 at 09:36:05AM +0100, jbradford@dial.pipex.com wrote:
> > > > > > > While 2.5 has worked better than I hoped for so far, I do have a problem 
> > > > > > > with the new input layer (I think) that is easily reproducible, and quite 
> > > > > > > irritating.
> > > > > > > 
> > > > > > > If I press and hold my left Alt key, press and release the right AltGr
> > > > > > > key, and then release the left Alt key, I get one of the following
> > > > > > > messages in dmesg:
> > > > > > 
> > > > > > [snip]
> > > > > > 
> > > > > > > The same thing happens for a few other combinations as well. I happens 
> > > > > > > both in X and in the console.
> > > > > > 
> > > > > > I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.
> > > > > > Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I
> > > > > > get unknown key messages in dmesg.
> > > > > > 
> > > > > > I posted about this a while ago, but I don't think anybody noticed :-)
> > > > > 
> > > > > Can you #define I8042_DEBUG_IO in i8042.h and send me the 'dmesg' output
> > > > > of the unknown key message and data around it?
> > > > 
> > > > OK, that was fun - every time I managed to cause the error, by the time I'd
> > > > switched to another VT, and typed dmesg, it was flooded with other keypresses
> > > > :-).  I should have used a serial terminal, but anyway, here goes:
> > > > 
> > > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694909]
> > > > i8042.c: f0 -> i8042 (kbd-data) [694909]
> > > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694912]
> > > > i8042.c: 00 -> i8042 (kbd-data) [694912]
> > > > i8042.c: fa <- i8042 (interrupt, kbd, 1) [694915]
> > > > i8042.c: 41 <- i8042 (interrupt, kbd, 1) [694916]
> > > > input: AT Set 2 keyboard on isa0060/serio0
> > > > i8042.c: 94 <- i8042 (interrupt, kbd, 1) [694937]
> > > > i8042.c: a3 <- i8042 (interrupt, kbd, 1) [694943]
> > > > i8042.c: 38 <- i8042 (interrupt, kbd, 1) [696272]
> > > > i8042.c: 3d <- i8042 (interrupt, kbd, 1) [696372]
> > > > i8042.c: bd <- i8042 (interrupt, kbd, 1) [696440]
> > > > i8042.c: b8 <- i8042 (interrupt, kbd, 1) [696446]
> > > > i8042.c: 1c <- i8042 (interrupt, kbd, 1) [697112]
> > > > 
> > > > This was in the syslog:
> > > > 
> > > > Oct  3 10:54:59 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0x94, on isa0060/serio0) pressed.
> > > 
> > > What's on the lines just before this one from i8042.c?
> > 
> > Forget the above report, I've since done a more comprehensive one, (below):
> 
> Yes, that one is perfect. Now some more tests to do with the keyboard:
> 
> 1) The same with i8042_direct on the kernel command line.

OK, here is the dmesg output - I've cut out things not releating to the keyboard.  This shows a boot followed by presses of - 'Henkaku/Zenkaku', '???', 'space', '???', and 'Hiragana/Romaji':

input: PC Speaker
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 16 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [0]
i8042.c: 5a -> i8042 (parameter) [0]
i8042.c: a5 <- i8042 (return) [0]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 36 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [2]
i8042.c: 16 <- i8042 (return) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 34 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 14 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 16 -> i8042 (parameter) [2]
i8042.c: d4 -> i8042 (command) [2]
i8042.c: ed -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [56]
i8042.c: 14 -> i8042 (parameter) [56]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [57]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 04 -> i8042 (parameter) [57]
i8042.c: 60 -> i8042 (command) [57]
i8042.c: 05 -> i8042 (parameter) [57]
i8042.c: ed -> i8042 (kbd-data) [58]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [61]
i8042.c: 00 -> i8042 (kbd-data) [61]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [63]
i8042.c: f2 -> i8042 (kbd-data) [63]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [66]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [67]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [68]
i8042.c: f8 -> i8042 (kbd-data) [68]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [71]
i8042.c: f4 -> i8042 (kbd-data) [71]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [75]
i8042.c: ea -> i8042 (kbd-data) [75]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [78]
i8042.c: f0 -> i8042 (kbd-data) [78]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [81]
i8042.c: 02 -> i8042 (kbd-data) [81]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [83]
i8042.c: f0 -> i8042 (kbd-data) [83]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [86]
i8042.c: 00 -> i8042 (kbd-data) [86]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [89]
i8042.c: 02 <- i8042 (interrupt, kbd, 1) [90]
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
i8042.c: 00 <- i8042 (interrupt, kbd, 1) [138631]
atkbd.c: Unknown key (set 2, scancode 0x0, on isa0060/serio0) pressed.
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199889]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [199972]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [199974]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200469]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [200554]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200555]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [200922]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201024]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201025]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201415]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [201516]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [201518]

> 2) The same with i8042_direct and atkbd_set=3 on the kernel command line.
> 
> It may make the extra keyboards work and will definitely explain what's
> happening in greater detail.

Right, this one is interesting - same keypresses as above, and this time the keys work, (excellent :-) ), Henkaku/Zenkaku is mapped to backtick, (as expected, as I am using a Russian keymap), and the other extra keys are not mapped to anything, (again, as to be expected).

input: PC Speaker
i8042.c: 20 -> i8042 (command) [0]
i8042.c: 47 <- i8042 (return) [0]
i8042.c: 60 -> i8042 (command) [0]
i8042.c: 16 -> i8042 (parameter) [0]
i8042.c: d3 -> i8042 (command) [1]
i8042.c: 5a -> i8042 (parameter) [1]
i8042.c: a5 <- i8042 (return) [1]
i8042.c: a9 -> i8042 (command) [1]
i8042.c: 00 <- i8042 (return) [1]
i8042.c: a7 -> i8042 (command) [1]
i8042.c: 20 -> i8042 (command) [1]
i8042.c: 36 <- i8042 (return) [1]
i8042.c: a8 -> i8042 (command) [2]
i8042.c: 20 -> i8042 (command) [2]
i8042.c: 16 <- i8042 (return) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 34 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [2]
i8042.c: 14 -> i8042 (parameter) [2]
i8042.c: 60 -> i8042 (command) [3]
i8042.c: 16 -> i8042 (parameter) [3]
i8042.c: d4 -> i8042 (command) [3]
i8042.c: ed -> i8042 (parameter) [3]
i8042.c: 60 -> i8042 (command) [56]
i8042.c: 14 -> i8042 (parameter) [56]
i8042.c: fe <- i8042 (interrupt, aux, 12, timeout) [57]
serio: i8042 AUX port at 0x60,0x64 irq 12
i8042.c: 60 -> i8042 (command) [58]
i8042.c: 04 -> i8042 (parameter) [58]
i8042.c: 60 -> i8042 (command) [58]
i8042.c: 05 -> i8042 (parameter) [58]
i8042.c: ed -> i8042 (kbd-data) [58]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [61]
i8042.c: 00 -> i8042 (kbd-data) [61]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [63]
i8042.c: f2 -> i8042 (kbd-data) [63]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [66]
i8042.c: ab <- i8042 (interrupt, kbd, 1) [67]
i8042.c: 90 <- i8042 (interrupt, kbd, 1) [68]
i8042.c: f8 -> i8042 (kbd-data) [68]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [71]
i8042.c: f4 -> i8042 (kbd-data) [71]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [75]
i8042.c: ea -> i8042 (kbd-data) [75]
i8042.c: fe <- i8042 (interrupt, kbd, 1) [78]
i8042.c: f0 -> i8042 (kbd-data) [78]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [81]
i8042.c: 03 -> i8042 (kbd-data) [81]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [83]
i8042.c: f0 -> i8042 (kbd-data) [83]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [86]
i8042.c: 00 -> i8042 (kbd-data) [86]
i8042.c: fa <- i8042 (interrupt, kbd, 1) [89]
i8042.c: 03 <- i8042 (interrupt, kbd, 1) [90]
input: AT Set 3 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack version 2.1 (1024 buckets, 8192 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37041]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [37142]
i8042.c: 0e <- i8042 (interrupt, kbd, 1) [37143]
i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41289]
atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) pressed.
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [41382]
i8042.c: 85 <- i8042 (interrupt, kbd, 1) [41384]
atkbd.c: Unknown key (set 3, scancode 0x85, on isa0060/serio0) released.
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42385]
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [42478]
i8042.c: 29 <- i8042 (interrupt, kbd, 1) [42480]
i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43519]
atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) pressed.
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [43596]
i8042.c: 86 <- i8042 (interrupt, kbd, 1) [43598]
atkbd.c: Unknown key (set 3, scancode 0x86, on isa0060/serio0) released.
i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45273]
atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) pressed.
i8042.c: f0 <- i8042 (interrupt, kbd, 1) [45366]
i8042.c: 87 <- i8042 (interrupt, kbd, 1) [45367]
atkbd.c: Unknown key (set 3, scancode 0x87, on isa0060/serio0) released.

Interestingly, I wasn't able to reproduce the bashing multiple keys error, using i8042_direct or atkbd_set=3.

John.
