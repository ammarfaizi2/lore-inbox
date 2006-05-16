Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWEPPBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWEPPBN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWEPPBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:01:13 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:48301 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751192AbWEPPBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:01:12 -0400
Message-ID: <4469E936.1020804@vc.cvut.cz>
Date: Tue, 16 May 2006 17:01:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: ravinandan.arakali@neterion.com, "Peter. Phan" <peter.phan@neterion.com>,
       Leonid Grossman <Leonid.Grossman@neterion.com>,
       linux-kernel@vger.kernel.org
Subject: Re: MSI-X support on AMD 8132 platforms ?
References: <MAEEKMLDLDFEGKHNIJHIOECKCEAA.ravinandan.arakali@neterion.com>	<MAEEKMLDLDFEGKHNIJHIKEIMCEAA.ravinandan.arakali@neterion.com> <p73hd3r5czi.fsf@bragg.suse.de>
In-Reply-To: <p73hd3r5czi.fsf@bragg.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
0xF4-0xFF from config space of 1022:7458 devices)  By default dword at 0xF4 is 
0xA8000008, disabling MSI/MSI-X mapping -> hypertransport interrupts.  Changing 
this to 0xA8010008 should enable this translation (iff qword at 0xF8 is 
0x0000FEE00000), allowing MSI to work on respective secondary/subordinate 
busses.  Unfortunately kernel ignores these HT capabilities...
								Petr

