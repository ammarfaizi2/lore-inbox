Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJNAHM>; Sat, 13 Oct 2001 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271978AbRJNAGy>; Sat, 13 Oct 2001 20:06:54 -0400
Received: from [209.250.58.96] ([209.250.58.96]:19208 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271911AbRJNAGm>; Sat, 13 Oct 2001 20:06:42 -0400
Date: Sat, 13 Oct 2001 19:06:58 -0500
From: Steven Walter <srwalter@yahoo.com>
To: pd <pdickson@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI modem doesn't work after 2.4.2->2.4.10 upgrade
Message-ID: <20011013190658.A32535@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>, pd <pdickson@att.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01101319043002.01369@gabrielle.pdickson.newboston.nh.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01101319043002.01369@gabrielle.pdickson.newboston.nh.us>; from pdickson@att.net on Sat, Oct 13, 2001 at 07:04:30PM -0400
X-Uptime: 5:54pm  up 22:04,  0 users,  load average: 1.10, 1.04, 1.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike 2.4.2, 2.4.10 can automatically detect and configure PCI modems.
That's why its already in use to setserial.  The kernel has already
found your modem, and assigned it ttyS4 (0-3 are reserved for the
standard COM1-4).  Theoretically, then, all you have to do is relink
/dev/modem to /dev/ttyS4, and you should be set.

If you had read through 'dmesg', and the problem if what I suspect it
is, you would have seen this pretty obviously.

On Sat, Oct 13, 2001 at 07:04:30PM -0400, pd wrote:
> I was running kernel 2.4.2 just fine with my US Robotics PCI modem.
> When I upgrade the kernel to 2.4.10 the modem no longer works.
> 
> Configuration:
>    Red Hat 7.1 distribution, 256MB memory, Dell Optiplex
>    lspci reports the modem as follows:
> 
> 02:09.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01)
>   (prog-if 02 [16550])
> 	Subsystem: US Robotics/3Com: Unknown device 00d7
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR+ FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at dcf8 [size=8]
> 	Capabilities: [dc] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
> 
> I have the modem configured as /dev/ttyS2.  The system has two real serial
> ports at ttyS0 and ttyS1.   /dev/modem is a link to /dev/ttyS2.
> setserial reports as follows on 2.4.2:
> 
> 	  /dev/ttyS2, UART: 16550A, Port: 0xdcf8, IRQ: 5
> 
> On 2.4.10 setserial reports as follows instead:
> 
> 	  /dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
> 
> I can change the uart type and IRQ settings just fine, to match those
> shown on 2.4.2.  But when I use setserial to change the IO port address
> to 0xdcf8 on 2.4.10 I get a message that the address is already in use.
> 
> Another clue is when rebooting from one kernel to the other a KUDZU
> window appears saying that the modem has been removed and do I want to
> change the configuration.  I always say keep the old configuration.
> 
> The modem continues to work just fine on 2.4.2.
> 
> A further clue is the following "Multimedia" device reported by lspci.
> Note the IO port addresses:
> 
> 02:0b.0 Multimedia controller: CMD Technology Inc PCI0647 (prog-if 8f)
> 	Subsystem: CMD Technology Inc PCI0647
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Latency: 64 (500ns min, 1000ns max)
> 	Interrupt: pin A routed to IRQ 5
> 	Region 0: I/O ports at dcf0 [size=8]
> 	Region 1: I/O ports at dce8 [size=4]
> 	Region 2: I/O ports at dcd8 [size=8]
> 	Region 3: I/O ports at dcd0 [size=4]
> 	Region 4: I/O ports at dcb0 [size=16]
> 
> The Region 0 port at dcf0, plus its size of 8 is dcf8, where the modem is.
> Does 2.4.10 think that dcf0+8 is using dcf8 where 2.4.2 does not?
> 
> The only difference in the lspci listings is as follows.  The entry for
> an Intel Bridge chip actually has an additional line in it on 2.4.10, the
> last line below showing "pin ? routed to IRQ 9".  Since the hardware
> is identical for both boots, I would think the lspci listings to be
> identical.
> 
> 00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Interrupt: pin ? routed to IRQ 9
> 
> -pd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin
