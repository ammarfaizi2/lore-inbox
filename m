Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262988AbTHWQr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 12:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTHWQr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:47:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262988AbTHWQrO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 12:47:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test4 - lost ACPI
Date: Sat, 23 Aug 2003 12:47:04 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC7@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test4 - lost ACPI
Thread-Index: AcNpZWdMqBuCCjpRTBKizHA1OzgTZwAKkzHQ
From: "Brown, Len" <len.brown@intel.com>
To: "Tomasz Torcz" <zdzichu@irc.pl>, "LKML" <linux-kernel@vger.redhat.com>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Aug 2003 16:47:05.0591 (UTC) FILETIME=[2F4A3870:01C36996]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you're using run-time ACPI features, you'll probably want to
make sure that your MB BIOS is the latest available.

I didn't see which VIA 693 MB you've got, but it could be that a
BIOS upgrade would move it from 09/13/00 to something past 1/1/2001 --
the (yes, arbitrary) cutoff for enabling ACPI by default.

Or you could add "acpi=force" to your command line, as suggested in the
dmesg output.

Or you could change the source to alter or disable #define
ACPI_BLACKLIST_CUTOFF_YEAR 2001

If your system misbehaves when ACPI is enabled by one of these methods,
please let me know.

Thanks,
-Len


> -----Original Message-----
> From: Tomasz Torcz [mailto:zdzichu@irc.pl] 
> Sent: Saturday, August 23, 2003 6:53 AM
> To: LKML
> Subject: 2.6.0-test4 - lost ACPI
> 
> 
> 
> Hi,
> 
> I am using ACPI for few years now. As far as I can see, on my
> machine it is only usfeul for binding events to Power button (like
> running fbdump) and for powering off. I'm also experimenting
> with swsusp, which I run by /proc/acpi/sleep.
> 
> 2.6.0-test4 has a surprise for me:
> 
> Linux version 2.6.0-test4 (zdzichu@mother) (gcc version 
> 3.3.1) #15 Sat Aug 23 12:03:
> 02 CEST 2003
> Video mode to be used for restore is ffff
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000013ff0000 (usable)
>  BIOS-e820: 0000000013ff0000 - 0000000013ff3000 (ACPI NVS)
>  BIOS-e820: 0000000013ff3000 - 0000000014000000 (ACPI data)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 319MB LOWMEM available.
> On node 0 totalpages: 81904
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 77808 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> DMI 2.1 present.
> ACPI disabled because your bios is from 00 and too old
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> You can enable it with acpi=force
> ACPI: RSDP (v000 VIA693                                    ) 
> @ 0x000f70c0
> ACPI: RSDT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) 
> @ 0x13ff3000
> ACPI: FADT (v001 AWARD  AWRDACPI 0x42302e31 AWRD 0x00000000) 
> @ 0x13ff3040
> ACPI: DSDT (v001 VIA693 AWRDACPI 0x00001000 MSFT 0x0100000a) 
> @ 0x00000000
> 
> WTF? My BIOS was perfectly good all those years! And no, there is
> no upgrade for my motherboard available. Using acpi=force is ugly
> and un-understandable.
> 
> There are also some strange directories in /proc :
> dr-xr-xr-x    2 root     root            0 Aug 23 12:50 
> /proc/ac_adapter/
> dr-xr-xr-x    2 root     root            0 Aug 23 12:50 /proc/fan
> 
> they are empty, but they should be in /proc/acpi/
> 
> Attached files:
> Output from dmidecode, lspci -v, my dmesg and /proc/cpuinfo
> 
> [Please CC me on replies. Thank you].
> 
> -- 
> Tomasz Torcz                 "God, root, what's the difference?" 
> zdzichu@irc.-nie.spam-.pl         "God is more forgiving."   
> 
