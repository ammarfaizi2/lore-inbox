Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbTLINwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbTLINwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:52:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:27540 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265831AbTLINvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:51:41 -0500
Date: Tue, 9 Dec 2003 14:51:34 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Badness in kobject_get at lib/kobject.c:439
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <9528.1070977894@www16.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm trying to get udev running and managed to get almost all
needed patches /* except input, sound */ in the kernel, but when i
i try to boot a kernel with the patch for sysfs & misc devices,
i get the following oops

PCI->APIC IRQ transform: (B0,I16,P1) -> 21
PCI->APIC IRQ transform: (B0,I16,P2) -> 21
PCI->APIC IRQ transform: (B0,I16,P3) -> 21
PCI->APIC IRQ transform: (B0,I18,P0) -> 23
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Badness in kobject_get at lib/kobject.c:439
Call Trace: [<c01997c4>]  [<c01dcea3>]  [<c01dd137>]  [<c01cbabc>] 
[<c01cbca8>]
  [<c0337fd8>]  [<c03306ce>]  [<c01050b4>]  [<c0105082>]  [<c01091f1>]
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
c017fab3
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c017fab3>]    Not tainted VLI
EFLAGS: 00010282
eax: c1a37f28   ebx: c1bee994   ecx: c03182e8   edx: 00000000
esi: 00000000   edi: c1a37f28   ebp: c1a37f10   esp: c1a37f04
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c1a36000 task=f7f9d900)
Stack: c1bee994 c1bee994 c03182a0 c1a37f30 c017fb84 c1bee994 00000000
c1bee998
       c1a37f28 00000000 00000000 c1a37f44 c01991f2 c1bee994 c1bee994
c03122f4
       c1a37f5c c01995b4 c1bee994 c03122e0 c1bee994 c1bee9dd c1a37f78
c01dd15d
Call Trace: [<c017fb84>]  [<c01991f2>]  [<c01995b4>]  [<c01dd15d>] 
[<c01cbabc>]
  [<c01cbca8>]  [<c0337fd8>]  [<c03306ce>]  [<c01050b4>]  [<c0105082>] 
[<c01091f1>]
Code: f8 ff eb b6 55 89 e5 8b 45 08 ff 40 24 c7 40 78 c0 51 2e c0 c7 40 7c
60 51
 2e c0 31 c0 5d c3 55 89 e5 57 8b 7d 14 56 8b 75 0c 53 <8b> 46 08 8d 48 68
ff 48
 68 0f 88 a3 02 00 00 ff 75 10 56 e8 a9
 <0>Kernel panic: Attempted to kill init!

that is both without/ with the other sysfs patches (vcs, fb,mem)

if i apply only the fb,mem,vcs patches i don't have the problem

this is mostly a  10-mm1(without kgdb) + test11

any ideas ?

best,

svetjo

PS.
please CC me as i'm not subscribed to the list

PS.2 a udev question
1.)
is it possible to create  cdrom devices ?
currently all ide device are named hd[x]
2.)  the -D modifier seems a bit incomplete
devfs would name hd's "disk/part[n]" and cd's "cd"
and i think it should be possible to construct directory path
automaticaly, and should i really least each channel separately ?
i've 4ch ide controller + 2ch on-board which results in :
----------------
NUMBER, BUS="ide", id="0.0", NAME="ide/host0/bus0/target0/lun0/%D",
SYMLINK="hda%n"
NUMBER, BUS="ide", id="0.1", NAME="ide/host0/bus0/target1/lun0/%D",
SYMLINK="hdb%n"
NUMBER, BUS="ide", id="1.0", NAME="ide/host0/bus1/target0/lun0/%D",
SYMLINK="hdc%n"
NUMBER, BUS="ide", id="1.1", NAME="ide/host0/bus1/target1/lun0/%D",
SYMLINK="hdd%n"
NUMBER, BUS="ide", id="2.0", NAME="ide/host2/bus0/target0/lun0/%D",
SYMLINK="hde%n"
NUMBER, BUS="ide", id="2.1", NAME="ide/host2/bus0/target1/lun0/%D",
SYMLINK="hdf%n"
NUMBER, BUS="ide", id="3.0", NAME="ide/host2/bus1/target0/lun0/%D",
SYMLINK="hdg%n"
NUMBER, BUS="ide", id="3.1", NAME="ide/host2/bus1/target1/lun0/%D",
SYMLINK="hdh%n"
NUMBER, BUS="ide", id="4.0", NAME="ide/host4/bus0/target0/lun0/%D",
SYMLINK="hdi%n"
NUMBER, BUS="ide", id="4.1", NAME="ide/host4/bus0/target1/lun0/%D",
SYMLINK="hdj%n"
NUMBER, BUS="ide", id="5.0", NAME="ide/host4/bus1/target0/lun0/%D",
SYMLINK="hdk%n"
NUMBER, BUS="ide", id="5.1", NAME="ide/host4/bus1/target1/lun0/%D",
SYMLINK="hdl%n"
-----------------

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


