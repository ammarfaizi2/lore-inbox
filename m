Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268772AbUHLUl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268772AbUHLUl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 16:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268754AbUHLUlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 16:41:52 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:40710 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S268782AbUHLUkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 16:40:51 -0400
Message-ID: <411BD5D2.5090604@optonline.net>
Date: Thu, 12 Aug 2004 16:40:50 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SCSI midlayer power management
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz> <411A1B72.1010302@optonline.net> <1092231462.2087.3.camel@mulgrave> <1092267400.2136.24.camel@gaston> <1092314892.1755.5.camel@mulgrave> <20040812131457.GB1086@elf.ucw.cz> <1092328173.2184.15.camel@mulgrave> <20040812191120.GA14903@elf.ucw.cz> <1092339247.1755.36.camel@mulgrave> <20040812202622.GD14556@elf.ucw.cz> <1092342716.2184.56.camel@mulgrave>
In-Reply-To: <1092342716.2184.56.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2004-08-12 at 16:26, Pavel Machek wrote:
> 
>>Yes.
> 
> 
> Well, that makes the suspend and resume functions rather complex. 
> They're not going to be coded simply if we have to save and restore the
> register state of the cards and reinitialise them.  I assume if you had
> to pick three drivers to do this for, that would be aic7xxx, aic79xx and
> sym_2?

S3 suspend-to-RAM has the same requirement. When the system enters S3, 
the PCI slot loses all physical power and the card's registers are 
completely gone.

So I've already had to fix up the aic7xxx driver to, among other things, 
reset the DMA base addres on resume. This should help for swsusp. 
Although maybe there are other requirements for swsusp... I think for 
swsusp we have to cope with a resume request that seems to come out of 
nowhere.

> 
> James
> 
> 
> 

