Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWG3SpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWG3SpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWG3SpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:45:04 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:715 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932424AbWG3SpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:45:03 -0400
Date: Sun, 30 Jul 2006 20:44:43 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk, davej@redhat.com,
       venkatesh.pallipadi@intel.com, tony@atomide.com, akpm@osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: 2.6.17 -> 2.6.18 regression: cpufreq broken since 2.6.18-rc1 on	pentium4
Message-ID: <20060730184443.GA30067@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	linux-kernel@vger.kernel.org, zwane@arm.linux.org.uk,
	davej@redhat.com, venkatesh.pallipadi@intel.com, tony@atomide.com,
	akpm@osdl.org, cpufreq@lists.linux.org.uk
References: <20060730120844.GA18293@outpost.ds9a.nl> <20060730160738.GB13377@irc.pl> <20060730165137.GA26511@outpost.ds9a.nl> <44CCF556.2060505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CCF556.2060505@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 10:07:18PM +0400, Alexey Starikovskiy wrote:
> Do I understand your logs right and acpi-cpufreq is already loaded and 
> works on your processor?

Yes, I can load it, but I'm unable to figure out what it is supposed to do,
or if it is doing anything.

> Do you have any info in /sys/devices/system/cpu/cpu0/cpufreq ?

No, not with just acpi-cpufreq loaded. With the help of Zwane, I've
discovered that if I unload acpi-cpufreq, I *can* load p4-clockmod, and then
the directory you mention appears, and I can configure governors, and life
is good. This all on 2.6.18-rc3.

Do I understand correctly that acpi-cpufreq is supposed to offer comparable
features?

Perhaps acpi-cpufreq *has* loaded, but did not find the proper hooks, but
has now registered itself, thus blocking p4-clockmod? When everything is
in-kernel, acpi-cpufreq might register itself first, which would lead to the
same thing.

For completeness, lspci. This is a desktop system, but I need some kind of
governer for quiet running.

$ lspci
0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O Controller (rev 04)
0000:00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root Port (rev 04)
0000:00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL Express Chipset Family Graphics Controller (rev 04)
0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03)
0000:00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 03)
0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
0000:06:00.0 Network controller: Techsan Electronics Co Ltd B2C2 FlexCopII DVB chip / Technisat SkyStar2 DVB card (rev 02)
0000:06:08.0 Ethernet controller: Intel Corporation 82562ET/EZ/GT/GZ - PRO/100 VE (LOM) Ethernet Controller (rev 01)

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
