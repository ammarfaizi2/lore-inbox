Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTJQXxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTJQXxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:53:31 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:33698 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S261240AbTJQXx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:53:27 -0400
Date: Fri, 17 Oct 2003 16:53:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 3c59x problem with 2.4.6-test[34]
Message-ID: <20031017235325.GA957@ip68-0-152-218.tc.ph.cox.net>
References: <20030907212348.GA836@ip68-0-152-218.tc.ph.cox.net> <20030929151827.GB862@ip68-0-152-218.tc.ph.cox.net> <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015183505.GA963@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:35:06AM -0700, Tom Rini wrote:
> On Mon, Sep 29, 2003 at 08:18:27AM -0700, Tom Rini wrote:
> > On Sun, Sep 07, 2003 at 02:23:48PM -0700, Tom Rini wrote:
> > > Hello.  I've run into an odd problem with the 3c59x driver on
> > > 2.6.0-test[34] (and 2.6.0-test4-mm6).  First, from scripts/ver_linux:
> > > 
> > > If some fields are empty or look unusual you may have an old version.
> > > Compare to the current minimal requirements in Documentation/Changes.
> > >  
> > > Linux opus 2.6.0-test4 #2 SMP Sat Sep 6 20:43:52 MST 2003 i686 GNU/Linux
> > >  
> > > Gnu C                  3.3.2
> > > Gnu make               3.80
> > > util-linux             2.11z
> > > mount                  2.11z
> > > e2fsprogs              1.35-WIP
> > > PPP                    2.4.1
> > > nfs-utils              1.0.5
> > > Linux C Library        2.3.2
> > > Dynamic linker (ldd)   2.3.2
> > > Procps                 3.1.11
> > > Net-tools              1.60
> > > Console-tools          0.2.3
> > > Sh-utils               5.0.90
> > > Modules Loaded         parport_pc lp parport ipt_REJECT iptable_filter ipt_MASQUERADE ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack ip_tables 8250 core soundcore microcode rtc tulip crc32 af_packet 3c59x hid uhci_hcd usbcore ext2
> > > 
> > > and lspci:
> > > 00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
> > > 00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
> > > 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
> > > 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> > > 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> > > 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
> > > 00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
> > > 00:0c.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI]
> > > 00:0d.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
> > > 00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
> > > 00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
> > > 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
> > > 
> > > What seems to happen on every other boot (and just rebooting the machine
> > > will 'fix' this) is that when 3c59x is loaded I get:
> > > 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> > > 0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe480. Vers LK1.1.19
> > >   ***WARNING*** No MII transceivers found!
> > > 
> > > and then dhcp never gets an IP.   Virtually all of 2.4 has run just fine
> > > in this particular setup.
> > 
> > This is still a problem with 2.6.0-test6.
> 
> And with 2.6.0-test7.

.. and 2.6.0-test8.

A full lspci on the card gives:
$ sudo lspci -vvv -s 00:0e.0
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at e480 [size=128]
        Region 1: Memory at febffd80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at febc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
Tom Rini
http://gate.crashing.org/~trini/
