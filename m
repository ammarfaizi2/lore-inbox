Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315553AbSEGOXm>; Tue, 7 May 2002 10:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315594AbSEGOXl>; Tue, 7 May 2002 10:23:41 -0400
Received: from florence.ie.alphyra.com ([193.120.224.170]:9618 "EHLO
	florence.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S315553AbSEGOXk>; Tue, 7 May 2002 10:23:40 -0400
Date: Tue, 7 May 2002 15:23:36 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: linux-kernel@vger.kernel.org
Subject: eepro100: wait_for_cmd_done timeout (2.4.19-pre2/8)
Message-ID: <Pine.LNX.4.44.0205071454270.16371-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have a problem with a Dell poweredge with onboard Intel eepro NICs.

The network card basically doesnt work. The system logs are filled 
with:

	eepro100: wait_for_cmd_done timeout!

and of course attendant "last message repeated x times". at less 
frequent intervals we get NETDEV watchdog messages:

	NETDEV WATCHDOG: eth0: transmit timed out

always followed by an error message which may be descriptive:

	eth0: Transmit timed out: status 0090  0cf0 at 13
	70/1430 command 000c0000

the parameter following command is always 000c0000.
the parameter following status varies between:

	0050 0c80
	0050 0cf0
	0090 0c80
	0090 0cf0

distribution of the above is:

     5 	0050 0c80
    227 0050 0cf0
     22 0090 0c80
    120 0090 0cf0

the xxxxx/yyyyy number is always different.

lspci of the network interfaces concerned:

00:01.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Dell Computer Corporation: Unknown device 00da
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fe2ff000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at ecc0 [size=64]
        Region 2: Memory at fe100000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Dell Computer Corporation: Unknown device 00da
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at fe2fe000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at ec80 [size=64]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

kernel version is 2.4.19-pre8, however, exact same thing occurs with 
2.4.19-pre2. (its running pre8 cause we hoped it was a problem fixed 
since pre2)

mii-tool -v -v eth0 shows no difference (that i see) between the 
interface on the working machine and this "problem" machine:

non-working:

eth0: negotiated 100baseTx-FD flow-control, link ok
  registers for MII PHY 1: 
    3000 782d 02a8 0154 05e1 45e1 0001 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0a03 0000 0001 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
  product info: Intel 82555 rev 4
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

working machine:

eth0: negotiated 100baseTx-FD flow-control, link ok
  registers for MII PHY 1: 
    3000 782d 02a8 0154 05e1 45e1 0001 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0a03 0000 0001 0000 0000 0000 0000 0000
    0000 0000 0000 0000 0000 0000 0000 0000
  product info: Intel 82555 rev 4
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control

The strange thing is this machine has a sister machine, an identical
poweredge bought at the same time, hooked up to the same switch,
running the same software, (exact same kernel 2.4.19-pre2 as other
machine used to run), same link negotiated, which does not have this
problem. we have changed the cable obviously, but this made no 
difference.

looking at the code concerned:

static inline void wait_for_cmd_done(long cmd_ioaddr)
{
        int wait = 1000;
        do  udelay(1) ;
        while(inb(cmd_ioaddr) && --wait >= 0);
#ifndef final_version
        if (wait < 0)
                printk(KERN_ALERT "eepro100: wait_for_cmd_done timeout!\n");
#endif
}

it seems the driver simply wants to read from the NIC and this doesnt
succeed (after trying 1000 times).

this, along with the fact than an identical machine has no problems,
would suggest to me i have a hardware problem. Is this a valid
assumption or are there "funnies" with the eepro100 driver or hardware
that i should be aware of? (eg is it possible the eepro100 has gotten
into some weird state?).

NB: i also tried the intel e100 driver, and curiously it prints a very 
similar message to the eepro100 driver (wait_for_exec... in the case 
of the intel e100 driver).

NB2: this problem may be multicast related. it started happening after
we installed and ran zebra ospfd on the machines which uses multicast.  
however, running without ospfd does not cure it.

if anyone needs further info, i can provide it.

regards,

--paulj

