Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757302AbWKWJuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbWKWJuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbWKWJuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:50:50 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:18398 "EHLO
	outbound1-fra-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1757302AbWKWJut convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:50:49 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Add IDE mode support for SB600 SATA
Date: Thu, 23 Nov 2006 17:50:31 +0800
Message-ID: <FFECF24D2A7F6D418B9511AF6F3586020108CFF2@shacnexch2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add IDE mode support for SB600 SATA
Thread-Index: AccO1lRnokRB8fO+QlO5bzN7hdyksgAAZZTQ
From: "Conke Hu" <conke.hu@amd.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>, "Jeff Garzik" <jeff@garzik.org>
X-OriginalArrivalTime: 23 Nov 2006 09:50:37.0793 (UTC) FILETIME=[D425D510:01C70EE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Arjan van de Ven [mailto:arjan@infradead.org] 
Sent: Thursday, November 23, 2006 4:06 PM
To: Conke Hu
Cc: linux-kernel@vger.kernel.org; alan@lxorguk.ukuu.org.uk; Andrew Morton; Jeff Garzik
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA

On Thu, 2006-11-23 at 12:20 +0800, Conke Hu wrote:
> ATI SB600 SATA controller supports 4 modes: Legacy IDE, Native IDE, AHCI and RAID. Legacy/Native IDE mode is designed for compatibility with some old OS without AHCI driver but looses SATAII/AHCI features such as NCQ. This patch will make SB600 SATA run in AHCI mode even if it was set as IDE mode by system BIOS.


is this really the right thing? You're overriding a user chosen configuration here.... while that might be justifiable.. it's probably a good idea to at least provide a safety-valve for this one. The user might have made that selection very deliberately.

--
if you want to mail me at work (you don't), use arjan (at) linux.intel.com Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

-------------------------------

Hi Arjan,
    In my preivious patch(with the same email title "[PATCH] Add IDE mode support for SB600 SATA"), I provided a config option and kernel users (the "users" here includes kernel developers and linux fans) can use the sata controller as IDE or AHCI, but Andrew did not think that was good idea.

    [Quote from Andrew]
    I doubt if it's appropriate to do all this via ifdefs.  Users don't compile their kernels - others compile them for the users.  We need the one kernel
    binary to support both modes.   Possible?

Andrew means only one mode (i.e. ahci) support is enough, so I've re-writen this patch according to Alan's adavice, see bellow:

    [Quote from Alan Cox]
    That seems fine to me. I would have thought putting the code you have into the quirks.c file as you proposed was the better way to do this, but with the addition of the 
    #if defined (CONFIG_ATA_AHCI) || defined(CONFIG_ATA_AHCI_MODULE)
   
    #endif 
    around it

Hi Alan,
    Today I've sent out 2 patches about the same issue. one patch/solution is providing a config option to support both IDE driver and AHCI driver; another is using ahci driver for all modes. The two patches respectively corresond to two mails with the same title "[PATCH] Add IDE mode support for SB600 SATA", please take a look at both patches for more details.
    Which patch/solution do you think is acceptable? Or is there anything that needs to be improved?


Thank you!
Conke




