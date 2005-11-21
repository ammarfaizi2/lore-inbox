Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVKUJ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVKUJ2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKUJ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:28:33 -0500
Received: from outgoing.smtp.agnat.pl ([193.239.44.83]:47884 "EHLO
	outgoing.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932239AbVKUJ2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:28:33 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: cmulcahy@avesi.com
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
Date: Mon, 21 Nov 2005 10:28:03 +0100
User-Agent: KMail/1.9
Cc: Akira Tsukamoto <akira-t@suna-asobi.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1131498162.21752.102.camel@jones> <20051121030949.80C0.AKIRA-T@suna-asobi.com> <1132537722.9627.145.camel@harry>
In-Reply-To: <1132537722.9627.145.camel@harry>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511211028.04431.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 02:48, Christopher Mulcahy wrote:
> I am using arch amd64.
>
> I applied this patch.
>
> http://bugzilla.kernel.org/attachment.cgi?id=6061&action=view
>
> It applies to 2.6.14.2 so long as you remove the static declaration of
> 'int disable_timer_pin_1'
>
> It appears to have solved my problem.

I wonder is this is x86_64 only problem?

I'm having the same problem on dual xeon 1.8GHz i686 with HT enabled, kernel 
2.6.14.2-4smp. Clock runs twice fast. Previously I was using 2.6.11 kernel 
with no such problem.

cmdline is: acpi=ht nmi_watchdog=1

Unfortunately I can't do any testing right now on this machine but I'll try 
acpi_skip_timer_override cmdline option as soon as I can.

> Chris

00:00.0 Host bridge: Intel Corporation E7500 Memory Controller Hub (rev 03)
00:02.0 PCI bridge: Intel Corporation E7500/E7501 Hub Interface B PCI-to-PCI 
Bridge (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1) (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corporation 82801CA LPC Interface Controller (rev 
02)
00:1f.1 IDE interface: Intel Corporation 82801CA Ultra ATA Storage Controller 
(rev 02)
00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 02)
01:01.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 10)
01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 03)
02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 03)
02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge (rev 03)
03:03.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
04:01.0 Ethernet controller: Intel Corporation 82545EM Gigabit Ethernet 
Controller (Copper) (rev 01)

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:   47938745          0          0          0    IO-APIC-edge  timer
  2:          0          0          0          0          XT-PIC  cascade
  4:      41666          0          0          0    IO-APIC-edge  serial
  8:          3          0          0          0    IO-APIC-edge  rtc
145:          0          0          0          0   IO-APIC-level  
uhci_hcd:usb1
153:   49053282          0          0          0   IO-APIC-level  eth0
169:    3839290          0          0          0   IO-APIC-level  qla2300
177:   45129167          0          0          0   IO-APIC-level  eth1
NMI:   47939763   47939734   47939732   47939731
LOC:   47943502   47944012   47944469   47944277
ERR:          0
MIS:          0


-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
