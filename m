Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbRE2LSx>; Tue, 29 May 2001 07:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbRE2LSn>; Tue, 29 May 2001 07:18:43 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:12807 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S261819AbRE2LSf>;
	Tue, 29 May 2001 07:18:35 -0400
Message-ID: <3B12DCCF.6524A99@mail.utexas.edu>
Date: Tue, 29 May 2001 05:18:39 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-athlon i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        mfrisch@saturn.tlug.org, Axel.Thimm@physik.fu-berlin.de
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Frisch wrote:

> On Mon, May 28, 2001 at 05:57:12PM +0200, Axel Thimm wrote:
> > What is the status of the support for this chipset, found for example in an
> > ASUS A7A266? Judging from
> > http://www.acerlabs.com/eng/support/faqlnx.htm
> > one gets the impression that ALi is respectfully treating the Linux community.
>
> I cannot answer your question about the level of support this chipset
> has, but suffice it to say that my new (as of last week) A7A266 based
> system (1.2Ghz T-Bird w/256MB Crucial DDR RAM) is running 2.4.5 (and
> previous to that 2.2.18) quite nicely.
>
I finally jerked the braindead 8KTA3 out of one of my new systems and
replaced it with an A7A266 about two weeks ago, and it has been smooth
sailing ever since.  The only problems that I'm are ware of are a
(maybe) DMA problem and a (maybe) SMBus problem, per below.  Right now
I've been up 6d 7h on an Athlon-optimized 2.4.4, and I think I had been
up a similar amount of trouble free uptime when I had to shut it down
due to thunderstorms last week.  FWIW, I'm also running a 1.2, but
with768MB of PC133 rather than DDR.

The swap provided an instant cure for a hole pile of annoying problems
that killed my system every few hours on the 8KTA3:  crashes, hard
hangs, unrequested GNOME session exits, and states where almost any
command I typed resulted in a segfault.  All that appears to be gone
now.


Re the (maybe) SMBus problem:

I installed Lm_sensors to watch my temperatures, and had to kluge it a
bit to get it to work.  In particular, I had to load the i2c-ali1535
module rather than the i2c-ali15x3 module that Lm_sensors decided I
needed.  (I did this on the basis of the chip<==>module associations
documented on the Lm_sensors page, ass-u-me-ing that the A7A266's
M1535D+ should use the module specified for the M1535D.)

However I now see this in /var/log/messages every few minutes:

May 29 04:39:28 pollux kernel: i2c-ali1535.o: Resetting entire SMB Bus
to clear busy condition (08)
May 29 04:39:28 pollux kernel: i2c-ali1535.o: SMBus reset failed! (0x08)
- controller or device on bus is probably hung

I assume that the problem is because the module isn't quite working
right for the D+ chip, but it does at least get my temperatures and
voltages, and I haven't noticed any ill side effects other than the
messages.  Maybe it will go away when a new version of Lm_sensors comes
out.


> Perhaps Linux is not optimized
> for performance with this chipset, but it feels fast to me.
>

I actually saw a consistent 2.7% speedup on a FP-intensive benchmark
that my research group uses, comparing the A7A266 to the 8KTA3 after the
switch, using the same hardware for everything else and with the BIOS
settings matched as closely as possible.


> According to 'hdparm -t /dev/hda', I am getting 25MB/s transfer rates
> with my Quantum Fireball Plus LM. Seems a little high, but drive
> performance 'feels' good.
>

I was getting around 32MB/s on my 8KTA3, but it dropped way down to 2.24
MB/sec after the upgrade.  The DMA is off, but I don't want to just turn
it on without investigating a possibly related problem first.


Re the (maybe) DMA problem:

I notice this whenever I boot, which may or may not all be relevant:

May 22 21:45:07 pollux kernel: ALI15X3: IDE controller on PCI bus 00 dev
20
May 22 21:45:07 pollux kernel: PCI: No IRQ known for interrupt pin A of
device 00:04.0. Please try using pci=biosirq.
May 22 21:45:07 pollux kernel: ALI15X3: chipset revision 196
May 22 21:45:07 pollux kernel: ALI15X3: not 100%% native mode: will
probe irqs later
May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
May 22 21:45:07 pollux kernel: ide0: ALI15X3 Bus-Master DMA disabled
(BIOS)
May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
May 22 21:45:07 pollux kernel: ide1: ALI15X3 Bus-Master DMA disabled
(BIOS)
...

May 22 21:45:07 pollux kernel: PCI: Enabling device 00:0d.0 (0000 ->
0001)
May 22 21:45:07 pollux kernel: PCI: Assigned IRQ 5 for device 00:0d.0
May 22 21:45:07 pollux kernel: Redundant entry in serial pci_table.
Please send the output of
May 22 21:45:07 pollux kernel: lspci -vv, this message
(4793,4104,4793,215)
May 22 21:45:07 pollux kernel: and the manufacturer and name of serial
board or modem board
May 22 21:45:07 pollux kernel: to serial-pci-info@lists.sourceforge.net.



I did send the information to serial-pci-info.

Notice that the kernel thinks it is talking to an ALI15X3, whereas my
manual seems to say that I actually have an M1535D+ instead.


While trying to discover a suitable IRQ for device 00:04.0, and noticed
this:

% /sbin/lspci -vv
...
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
(prog-if
fa)
        Subsystem: Asustek Computer, Inc.: Unknown device 8053
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at d400 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
...

The routing to IQR 0 sounds funny to me, but this is already way beyond
what I understand.

At any rate, I didn't want to enable DMA until I had time to ask whether
the messages quoted above were relevant, so I've just been living with a
slow disk.  Any suggestions will be appreciated, and of course I'll be
happy to supply more info if needed.



> Based on my weekend experience with this board and Linux, I think I have
> made the right choice.
>

I'm mostly happy with mine too, and if I could get my money back on a
couple of 8KTA3s I'd spend it on a DDR upgrade for the A7A266.


Bobby Bryant
Austin, Texas

p.s. - Please consider CCing me on any replies; I have unsubscribed from
linux-kernel for the next couple of weeks to keep my mailbox from
overflowing while I'm busy at something else.


