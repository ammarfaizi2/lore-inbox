Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUKIJuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUKIJuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUKIJuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:50:54 -0500
Received: from fmr12.intel.com ([134.134.136.15]:37590 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S261461AbUKIJum convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:50:42 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: parport not working in 2.6.9
Date: Tue, 9 Nov 2004 17:50:29 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057583D4F0@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: parport not working in 2.6.9
Thread-Index: AcTE82dcB6YS6hspQ8eHVV9IdHpu0gBTb7Cg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Ondrej Zary" <linux@rainbow-software.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2004 09:50:30.0757 (UTC) FILETIME=[8C9E3950:01C4C641]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I don't see ACPI anything related with the problem. The ACPI error message only effects suspend/resume. How about if you disable CONFIG_PARPORT_PC_CML1?
If still saw the issue, please try 'acpi=off'

Thanks,
Shaohua
_______________________________________
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Ondrej Zary
Sent: Monday, November 08, 2004 1:53 AM
To: Linux Kernel Mailing List
Subject: parport not working in 2.6.9

Hello, 
I've noticed that parallel port stopped working for me with 2.6.9. It works with 2.6.8.1 using the same .config - the relevant part:
CONFIG_PARPORT=y 
CONFIG_PARPORT_PC=y 
CONFIG_PARPORT_PC_CML1=y 
# CONFIG_PARPORT_SERIAL is not set 
CONFIG_PARPORT_PC_FIFO=y 
CONFIG_PARPORT_PC_SUPERIO=y 
# CONFIG_PARPORT_OTHER is not set 
CONFIG_PARPORT_1284=y 
I've noticed that there's "smsc parport" instead of parport0 in /proc/ioports and new smsc_check range but the 0778-077a range is no longer there. My board has SMC Super I/O chip.
Here's "diff ioports-2.6.8.1 ioports-2.6.9" output: 
3c3,4 
< 0040-005f : timer 
--- 
> 0040-0043 : timer0 
> 0050-0053 : timer1 
19c20 
< 0378-037a : parport0 
--- 
> 0378-037a : smsc parport 
22a24 
> 03f0-03f2 : smsc_check 
25d26 
< 0778-077a : parport0 
29c30,33 
<   4008-400b : ACPI timer 
--- 
>   4000-4003 : PM1a_EVT_BLK 
>   4004-4005 : PM1a_CNT_BLK 
>   4008-400b : PM_TMR 
>   400c-400f : GPE0_BLK 

I also see some new ACPI errors during 2.6.9 startup: 
ACPI: Subsystem revision 20040816 
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR1._PRW] (Node c7f89f40), AE_TYPE 
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR2._PRW] (Node c7f89e20), AE_TYPE 
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.LPT_._PRW] (Node c7f89c40), AE_TYPE 

and this: 
parport: PnPBIOS parport detected. 
pnp: Device 00:0e disabled. 

In 2.6.8.1, it's correct: 
parport: PnPBIOS parport detected. 
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA] 
lp0: using parport0 (interrupt-driven). 
If more details are needed, just ask. 
-- 
Ondrej Zary 
- 
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/ 
