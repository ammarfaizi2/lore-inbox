Return-Path: <linux-kernel-owner+w=401wt.eu-S932593AbXAJAyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXAJAyT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbXAJAyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:54:19 -0500
Received: from smtp-out.rrz.uni-koeln.de ([134.95.19.53]:39066 "EHLO
	smtp-out.rrz.uni-koeln.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbXAJAyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:54:18 -0500
Message-ID: <45A4391E.7080805@rrz.uni-koeln.de>
Date: Wed, 10 Jan 2007 01:53:50 +0100
From: Berthold Cogel <cogel@rrz.uni-koeln.de>
User-Agent: IceDove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de> <459D5079.70605@linux.intel.com> <459EE89F.1010505@rrz.uni-koeln.de> <459F6366.5080609@linux.intel.com> <45A13DF8.2030207@rrz.uni-koeln.de> <45A29C09.8050901@linux.intel.com>
In-Reply-To: <45A29C09.8050901@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Starikovskiy schrieb:
> Berthold Cogel wrote:
>> Alexey Starikovskiy schrieb:
>>
>>  
>>>> Hello Alex,
>>>>
>>>> I still get the same diffs. Except the yenta part of course. And the
>>>> system is still rebooting.
>>>>
>>>> Berthold
>>>>         
>>> Good, yenta is cleared :) Could you replace /drivers/acpi/ec.c with the
>>> version from 2.6.19.x and try again?
>>>
>>> Regards,
>>>    Alex.
>>>     
>>
>> Hi Alex!
>>
>> I did what you suggested. First I replaced ec.c in linux-2.6.20-rc2 (see
>> attached dmesg-2.6.20-rc2.ec.txt) with the version from linux-2.6.19.1
>> and in a second step I also replaced i2c_ec.c and i2c_ec.h
>> (dmesg-2.6.20-rc2.i2c_ec.txt).
>>
>> In both cases the only result I can see is the absence of the 'ACPI: EC:
>> evaluating' messages in the logs. The system is still rebooting instead
>> of doing a clean shutdown.
>>
>> Regards,
>> Berthold
>>
>>   
> Excellent, ACPI printing of queries is cleared as well :)
> There are two ways to debug further... git-bisect and unloading modules
> before shutdown (or not loading them)...
> While second is easier and could isolate a module, the first could be
> way more productive:
> http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt
> 
> 
> Thanks in advance,
>    Alex.
> 

Hi Alex!

I will have to set up git first for the bisect way. So I decided to give
the second way a try.

The module in question is ehci_hcd. After blacklisting it, 'shutdown -h
now' worked fine.

Here is the output of lspci for the system:

acer01:~# lspci
00:00.0 Host bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.1 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:00.3 System peripheral: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to I/O Controller (rev 02)
00:01.0 PCI bridge: Intel Corporation 82852/82855 GM/GME/PM/GMV
Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2
EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10]
02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:04.0 Network controller: Intel Corporation PRO/Wireless 2200BG
Network Connection (rev 05)
02:06.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
02:06.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
02:06.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller


Regards,
Berthold


