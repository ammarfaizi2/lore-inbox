Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751576AbWEPSoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbWEPSoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWEPSoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:44:55 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:2026 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1750748AbWEPSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:44:54 -0400
X-ASG-Debug-ID: 1147805090-26230-25-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: "Petr Vandrovec" <vandrove@vc.cvut.cz>, "Andi Kleen" <ak@suse.de>
Cc: "Peter. Phan" <peter.phan@neterion.com>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>,
       <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: RE: MSI-X support on AMD 8132 platforms ?
Subject: RE: MSI-X support on AMD 8132 platforms ?
Date: Tue, 16 May 2006 11:44:59 -0700
Message-ID: <MAEEKMLDLDFEGKHNIJHICEKBCEAA.ravinandan.arakali@neterion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
In-Reply-To: <4469E936.1020804@vc.cvut.cz>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,
Thanks for the suggestion.
What you pointed out was the source of the problem. After
enabling the  MSI-to-HTInterrupts(the value at offset 0xF6),
I now see interrupts and can ping in both MSI and MSI-X modes.

Ravi

-----Original Message-----
From: Petr Vandrovec [mailto:vandrove@vc.cvut.cz]
Sent: Tuesday, May 16, 2006 8:01 AM
To: Andi Kleen
Cc: ravinandan.arakali@neterion.com; Peter. Phan; Leonid Grossman;
linux-kernel@vger.kernel.org
Subject: Re: MSI-X support on AMD 8132 platforms ?


Andi Kleen wrote:
> "Ravinandan Arakali" <ravinandan.arakali@neterion.com> writes:
>
>
>>I was wondering if anybody has got MSI-X going on AMD 8132 platforms.
>>Our network card and driver support MSI-X and the combination works
>>fine on IA64 and xeon platforms. But on the 8132, the MSI-X vectors are
>>assigned(pci_enable_msix succeeds) but no interrupts get generated.
>
>
> See erratum #78 in the AMD 8132 Specification update.
> It doesn't support the MSI capability and there are no plans to fix that.
>
> AFAIK the only way to get MSI on Opteron is on PCI Express.

I do not think that erratum #78 is related to this - it is related to tunnel
itself generating MSI - which is not needed in this case.

>>Note that with a different OS, MSI-X does work on 8132.
>
> Are you sure?

Can you provide 'lspci -vvvxxx' output from AMD8132 bridge?  (esp. bytes
0xF4-0xFF from config space of 1022:7458 devices)  By default dword at 0xF4
is
0xA8000008, disabling MSI/MSI-X mapping -> hypertransport interrupts.
Changing
this to 0xA8010008 should enable this translation (iff qword at 0xF8 is
0x0000FEE00000), allowing MSI to work on respective secondary/subordinate
busses.  Unfortunately kernel ignores these HT capabilities...
								Petr


