Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbVJ1UeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbVJ1UeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbVJ1UeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:34:13 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:39835 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751681AbVJ1UeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:34:11 -0400
Message-ID: <43628B40.50902@cantab.net>
Date: Fri, 28 Oct 2005 21:34:08 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jbowler@acm.org
CC: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
References: <003d01c5dbdd$25ef6af0$1001a8c0@kalmiopsis>
In-Reply-To: <003d01c5dbdd$25ef6af0$1001a8c0@kalmiopsis>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bowler wrote:
> 
>>Also, I've noticed that the PCI_CSR is mis-configured when the XScale 
>>core is in little-endian mode.  ABE (AHB is big-endian) /must/ always be 
>>set -- remember that the NPEs are always big-endian devices.
> 
> 
> This doesn't affect the flash (we've verified that - i.e. *with* the
> patch the flash works in LE regardless of the patch for the PCI_CSR
> setting).

Now that you mention it I do remember seeing this patch floating around.

>>Since I'd never run an IXP4xx in little-endian mode I've not looked at 
>>this issue in any great depth so I could be wrong here.  Regardless, the 
>>proposed hack to the flash map driver is wrong since all expansion bus 
>>peripherals are affected not just flash (i.e., the solution needs to be 
>>more generic rather than flash driver specific).
> 
> 
> No, that's incorrect.  The patch has been demonstrated to be correct with
> all devices (along with the PCI_CSR patch, which Deepak has already pushed
> upstream).  I.e. *without* the patch everything works (BE and LE) except
> the flash is unuseable, *with* the patch the flash works too.

It appears that the NSLU2 only has the flash on the expansion bus which 
is why you believe it's a flash specific problem.

> So I'm effectively saying we need data coherency in the flash, but what we
> have in everything *else* is working just find with address coherency.

Data coherency can be set on a per 1 Mibyte page basis so all other (APB 
and PCI) peripherals would continue to use address coherency and thus 
would continue to function as they are now.

David Vrabel
