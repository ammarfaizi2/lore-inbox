Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131779AbQKAXJP>; Wed, 1 Nov 2000 18:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131769AbQKAXI6>; Wed, 1 Nov 2000 18:08:58 -0500
Received: from mx2.core.com ([208.40.40.41]:39829 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S131784AbQKAXIi>;
	Wed, 1 Nov 2000 18:08:38 -0500
Message-ID: <3A00B08A.13A971C0@megsinet.net>
Date: Wed, 01 Nov 2000 18:08:42 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@linux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <39FFB221.D6A1B5FF@megsinet.net> <3A006EFB.CD2EAF98@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> "M.H.VanLeeuwen" wrote:
> 
> > 3. Enabling PIIX4, kernel locks hard when printing the partition
> >    tables for hdc.   hdc has no partitions.
> >    I think this problem is on Ted's problem list???
> 
> Disable PIIXn tuning and recompile your kernel.  How does it fare now?
> 

Yep, disabling (opposite of "enabling") does allow the kernel to boot just fine.
PIIXn tuning must be tickling something on the system so that the first time we
read from the disk, partition check block 0, the system freezes hard.

I do know that w/o PIIXn tuning the result of the first block read is all zero's
hence the "/dev/ide/host0/bus0/target1/lun0: unknown partition table" message.

Any idea how to go about debugging this kind of lockup?
Guess i'll scrounge up a couple of disks and see if it's controller or disk related.

Weren't you also experiencing this type of problem on a laptop?  


Martin


lspci -v
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
