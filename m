Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267193AbUHDCIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267193AbUHDCIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267211AbUHDCIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:08:07 -0400
Received: from fmr06.intel.com ([134.134.136.7]:32690 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267193AbUHDCHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:07:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Small fix to make i2c-viapro.c work on ASUS A7V with ACPI enabled
Date: Wed, 4 Aug 2004 10:07:22 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F037BB96A@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Small fix to make i2c-viapro.c work on ASUS A7V with ACPI enabled
Thread-Index: AcR5n240TQQ8RhqZT4qUJU5h5reP2QAJ6cVQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: <eric.valette@free.fr>, "Greg KH" <greg@kroah.com>, <phil@netroedge.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Aug 2004 02:07:23.0768 (UTC) FILETIME=[C8366F80:01C479C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have made a patch for this issue. It's at http://bugme.osdl.org/show_bug.cgi?id=3049

Basically if the io ports are reported in a PCI device, it should not be included in ACPI motherboard resources list, but some BIOSs did (buggy BIOS?).

Thanks,
Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Eric Valette
>Sent: Wednesday, August 04, 2004 4:55 AM
>To: greg@kroah.com; phil@netroedge.com
>Cc: Andrew Morton; linux-kernel@vger.kernel.org
>Subject: Small fix to make i2c-viapro.c work on ASUS A7V with ACPI enabled
>
>Today, due to the heat, I tried to make lm-sensors work on my ASUS A7V
>KT133 motherboard in order to check the temperature (One fan already
>died without damaging the processor...).
>
>Hi,
>
>At least I suceeded to make lm-sensors work on ASUS A7V but encountered
>the following problem : i2c-viapro.c tries to request an ioports region
>(in my case 0xe800 see <====) that has already been allocated by the
>acpi motherboard.c code and fails whith an error if this region has
>already been allocated.
>
>I first tried to use the "force_addr" methods in i2c-viapro.c using a
>free ioport location but then lm-sensors works but code breakes ACPI
>support (fails to shutdown at least) as it reprogram the bus chip base
>address without ACPI code being notified.
>
>With the following patch targeted toward 2.6.8-rc2-mm2, both things
>works together like a charm. I have no idea if patch is correct but at
>least I think the analysis is. Let me know if you think there is a
>better fix.
>
>(prompt)sensors
>as99127f-i2c-2-2d
>Adapter: SMBus Via Pro adapter at e800  <==========
>VCore:     +1.81 V  (min =  +1.74 V, max =  +1.94 V)
>+3.3V:     +3.52 V  (min =  +3.20 V, max =  +3.54 V)
>+5V:       +5.05 V  (min =  +4.73 V, max =  +5.24 V)
>+12V:     +12.34 V  (min = +10.82 V, max = +13.19 V)
>-12V:     -12.33 V  (min = -13.22 V, max = -10.74 V)
>-5V:       -5.15 V  (min =  -5.25 V, max =  -4.74 V)
>fan1:        0 RPM  (min =    0 RPM, div = 2)
>fan2:     6958 RPM  (min = 2836 RPM, div = 2)                     (beep)
>fan3:        0 RPM  (min =    0 RPM, div = 2)
>M/B Temp:    +47°C  (high =  +105°C, hyst =    +0°C)
>CPU Temp:  +67.0°C  (high =   +95°C, hyst =   +80°C)          (beep)
>temp3:     -31.5°C  (high =  +122°C, hyst =  +121°C)
>vid:      +1.850 V
>alarms:
>beep_enable:
>           Sound alarm enabled
>
>(prompt) cat /proc/ioports
>0000-001f : dma1
>0020-0021 : pic1
>0040-005f : timer
>0060-006f : keyboard
>0070-0077 : rtc
>0080-008f : dma page reg
>00a0-00a1 : pic2
>00c0-00df : dma2
>00f0-00ff : fpu
>01f0-01f7 : ide0
>02f8-02ff : serial
>0378-037a : parport0
>03f6-03f6 : ide0
>03f8-03ff : serial
>0cf8-0cff : PCI conf1
>7800-783f : 0000:00:11.0
>   7800-7807 : ide2
>   7808-780f : ide3
>   7810-783f : PDC20265
>8000-8003 : 0000:00:11.0
>8400-8407 : 0000:00:11.0
>8800-8803 : 0000:00:11.0
>   8802-8802 : ide2
>9000-9007 : 0000:00:11.0
>   9000-9007 : ide2
>9400-94ff : 0000:00:0d.0
>9800-98ff : 0000:00:0b.0
>a000-a007 : 0000:00:0a.1
>a400-a41f : 0000:00:0a.0
>   a400-a41f : EMU10K1
>d000-d01f : 0000:00:04.3
>   d000-d01f : uhci_hcd
>d400-d41f : 0000:00:04.2
>   d400-d41f : uhci_hcd
>d800-d80f : 0000:00:04.1
>   d800-d807 : ide0
>   d808-d80f : ide1
>e200-e27f : 0000:00:04.4
>e400-e4ff : 0000:00:04.4
>   e400-e47f : motherboard
>e800-e80f : 0000:00:04.4	<===============
>   e800-e80f : motherboard
>
>--
>    __
>   /  `                   	Eric Valette
>  /--   __  o _.          	6 rue Paul Le Flem
>(___, / (_(_(__         	35740 Pace
>
>Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
>E-mail: eric.valette@free.fr
>
>

