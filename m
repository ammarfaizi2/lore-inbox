Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSCRPMV>; Mon, 18 Mar 2002 10:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSCRPMM>; Mon, 18 Mar 2002 10:12:12 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:30686 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311054AbSCRPMG>; Mon, 18 Mar 2002 10:12:06 -0500
Date: Mon, 18 Mar 2002 15:51:51 +0100
From: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Message-Id: <200203181451.g2IEppn00654@orion.steiner.local>
To: garloff@suse.de, linux-kernel@vger.kernel.org,
        Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: SCSI-Problem with AM53C974
In-Reply-To: <20020318124311.D19273@gum01m.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>On Mon, Mar 18, 2002 at 12:30:38PM +0100, Kurt Garloff wrote:
>> Can you try the attached patch please? Patch is against 2.4.18.
>

OK, after testing I can say:

After loading AM53C974 I can not load tmscsim any more!
But that's the only improvement so far. 

After loading tmscsim I can still load AM53C974, /var/log/messages
looks same as before:


Mar 18 15:11:03 orion kernel: PCI: Found IRQ 15 for device 00:0a.0
Mar 18 15:11:03 orion kernel: PCI: Sharing IRQ 15 with 00:07.5
Mar 18 15:11:03 orion kernel: scsi0 : AM53/79C974 PCscsi driver rev.
0.5; host I/O address: 0xc000; irq: 15
Mar 18 15:11:03 orion kernel: 
Mar 18 15:11:03 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB =
0!
Mar 18 15:11:09 orion kernel: scsi : aborting command due to timeout :
pid 41, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 0
Mar 18 15:11:12 orion kernel: SCSI host 0 abort (pid 41) timed out -
resetting
Mar 18 15:11:12 orion kernel: SCSI bus is being reset for host 0
channel 0.
Mar 18 15:11:12 orion kernel: AM53C974_reset called
Mar 18 15:11:12 orion kernel: AM53C974 register dump:
Mar 18 15:11:12 orion kernel: IO base: 0xc000; CTCREG: 0x120000;
CMDREG: 0x45; STATREG: 0x00; ISREG: 0xc0
Mar 18 15:11:12 orion kernel: CFIREG: 0x00; CNTLREG1-4: 0x57; 0x40;
0x18; 0x44
Mar 18 15:11:12 orion kernel: DMACMD: 0x80; DMASTC: 0x0100; DMASPA:
0x1549ddc0
Mar 18 15:11:12 orion kernel: DMAWBC: 0x00bc; DMAWAC: 0x1549de04;
DMASTATUS: 0x00
Mar 18 15:11:12 orion kernel:
---------------------------------------------------------
Mar 18 15:11:12 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB =
0!
Mar 18 15:11:20 orion kernel: SCSI host 0 abort (pid 43) timed out -
resetting
Mar 18 15:11:20 orion kernel: SCSI bus is being reset for host 0
channel 0.
Mar 18 15:11:20 orion kernel: AM53C974_reset called
Mar 18 15:11:20 orion kernel: AM53C974 register dump:
Mar 18 15:11:20 orion kernel: IO base: 0xc000; CTCREG: 0x120000;
CMDREG: 0x45; STATREG: 0x00; ISREG: 0xc0
Mar 18 15:11:20 orion kernel: CFIREG: 0x00; CNTLREG1-4: 0x57; 0x40;
0x18; 0x44
Mar 18 15:11:20 orion kernel: DMACMD: 0x80; DMASTC: 0x0100; DMASPA:
0x1549ddc0
Mar 18 15:11:20 orion kernel: DMAWBC: 0x00bc; DMAWAC: 0x1549de04;
DMASTATUS: 0x00
Mar 18 15:11:20 orion kernel:
---------------------------------------------------------
Mar 18 15:11:20 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB =
0!

[Still repeating until reboot]
Reboot now succeeds cleanly, but maybe it was my fault it fail before
while hanging in AM53C974. It sometimes seems to need some keys pressed 
to go on. (?!)


But there is another thing now happening:

After unloading any of the two drivers modprobing the AM53C974 fail
in the first try, even after waiting some time. Second try suceeds:

orion:~ # rmmod AM53C974
orion:~ # modprobe AM53C974
/lib/modules/2.4.18/kernel/drivers/scsi/AM53C974.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.18/kernel/drivers/scsi/AM53C974.o: insmod
/lib/modules/2.4.18/kernel/drivers/scsi/AM53C974.o failed
/lib/modules/2.4.18/kernel/drivers/scsi/AM53C974.o: insmod AM53C974
failed
orion:~ # modprobe AM53C974
orion:~ # 

Modprobing tmscsim succeeds on first try.

CU
Marion Steiner
 
