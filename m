Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbQJ1W2o>; Sat, 28 Oct 2000 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbQJ1W2Z>; Sat, 28 Oct 2000 18:28:25 -0400
Received: from janus.hosting4u.net ([209.15.2.37]:17939 "HELO
	janus.hosting4u.net") by vger.kernel.org with SMTP
	id <S131394AbQJ1W2W>; Sat, 28 Oct 2000 18:28:22 -0400
Message-ID: <39FB52CD.5BBC4017@a2zis.com>
Date: Sun, 29 Oct 2000 00:27:25 +0200
From: Remi Turk <remi@a2zis.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10-pre6-test1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: No IRQ known for interrupt pin A of device 00:0f.0]
In-Reply-To: <39FB2BCF.64A80D88@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Attached below is a message I just sent to someone else who is having
> the same problem as you.  Would it be possible for you to try the stuff
> I suggest in the message as well?
> 
> Thanks,
> 
>         Jeff
> 
> Subject: Re: No IRQ known for interrupt pin A of device 00:0f.0
> Date: Sat, 28 Oct 2000 15:38:49 -0400
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> Organization: MandrakeSoft
> To: Burton Windle <burton@fint.org>
> CC: andre@linux-ide.org, Linus Torvalds <torvalds@transmeta.com>,
>      mj@ucw.cz
> References: <Pine.LNX.4.21.0010281456180.9491-100000@fint.staticky.com>
> 
> Ok, the problem is that you have an interrupt router table for your Ali
> 1533, but no interrupt router entry for your IDE device.  That's why
> pci_enable_device is failing.
> 
> Would you mind testing two kernel patches for me?  Both of these changes
> should be attempted separately in 2.4.0-test10-pre6, and -without-
> Andre's change.
> 
> The first change attempts to build an interrupt router entry for you, if
> none is available.  I am most interested if this works.
> 
> The second change simply ignores any pci_enable_device error returns,
> and assumes that the IDE subsystem will pick up the pieces.
> 
> Remember, do not apply both of these changes at the same time...
> 
> Thanks,
> 
>         Jeff

The second patch (the one ignoring errors) doesn't seem to change
anything (except not giving the warning IIRC)
Also, dump_pirq and lspci -vv output didn't change.

The first says the following at boot:

PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
PCI: Found IRQ 14 for device 00:0f.0

dump_pirq output remains the same.
The lspci -vv output does change with the second patch:

 00:0f.0 IDE interface: Acer Laboratories Inc. M5229 (rev c1) (prog-if
fa)
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 	Latency: 2 min, 4 max, 32 set
-	Interrupt: pin A routed to IRQ 0
+	Interrupt: pin A routed to IRQ 14
 	Region 4: I/O ports at d000

More info on request.

-- 
Linux 2.4.0-test10-pre6-test1 #1 Sat Oct 28 23:04:32 CEST 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
