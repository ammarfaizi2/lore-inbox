Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSJEXbC>; Sat, 5 Oct 2002 19:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262809AbSJEXbC>; Sat, 5 Oct 2002 19:31:02 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:23293 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S262807AbSJEXbA>; Sat, 5 Oct 2002 19:31:00 -0400
Message-ID: <3D9F7779.579746C6@eyal.emu.id.au>
Date: Sun, 06 Oct 2002 09:36:25 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19: sym53c8xx problems
References: <Pine.LNX.4.44.0210051116120.20304-100000@filesrv1.baby-dragons.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mr. James W. Laferriere" wrote:
> 
>         Hello Eyal ,  I have a CP6000 unit (PPRO's tho) & am having no
>         such difficulties .  Now that said I rebuilt the WHOLE scsi
>         layout in the system in order to get rid of those older hotswap
>         cages (imo, they stink electrically) .  Btw , Stable as heck .
>         Wheres that forest I need to knock on ;-)

Sounds good

>         Is your scsi setup easy enough to make an ascii art description
>         of ?  If so would you post it please ?  From the messages below
>         it appears (to me) that their is some difficulty in the chain that
>         attaches to the python .  I have never seen those messages when I
>         have attached (albeit differant) tape drives , ie: DLT,dat2,dat3 .

As I mentioned the ONLY scsi device is the externally connected DDS-1
tape drive. It is a SCSI-2 narrow (50-pin) device. It uses a
HD-centronics->50pin-centronics cable.

I believe the BIOS on this machine really does not like and IDE disks
connected. It does have an IDE controller but will only allow the CD
drive on it, so we have a PCI/IDE controller installed to handle the
single IDE disk. The machine refuses to boot off the IDE but LILO is
happy to do so off a floppy.

BTW, I only have this machine in order to test out software on a 4-way
SMP machine, which is why we passed on installing more expensive scsi
disks.

Now, when I connect the cable to my tape, lilo fails to boot off the
floppy. It seems that the first BIOS disk (80h) which is detected
properly by the IDE controller is trashed by the scsi controller
(which initialises later than the IDE). So we now boot off the floppy
directly (i.e. the kernel boots off the floppy, not just lilo).

Finally, now that we are booting just fine, and the scsi tape drive
is clearly detected at bootup by the kernel, I see that the scsi
driver does not stay loaded (maybe the boot process loads it, and
if there are no disks it unloads it?). So I try to load it myself
	modprobe sym53c8xx
and this kills the machine.

By "kills" I mean the machine stutters for a few seconds, and then
locks up, not even vt switching. No message is ever displayed.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
