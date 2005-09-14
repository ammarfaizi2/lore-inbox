Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVINF46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVINF46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVINF44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:56:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:13956 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S965025AbVINF4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:56:55 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: Sergey Panov <sipan@sipan.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050913154014.GE32395@parisc-linux.org>
References: <1126308949.4799.54.camel@mulgrave>
	 <20050910041218.29183.qmail@web51612.mail.yahoo.com>
	 <20050911093847.GA5429@infradead.org> <4325FA6F.3060102@adaptec.com>
	 <20050913154014.GE32395@parisc-linux.org>
Content-Type: text/plain
Organization: Home
Date: Wed, 14 Sep 2005 01:56:27 -0400
Message-Id: <1126677387.26050.71.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 09:40 -0600, Matthew Wilcox wrote:
> On Mon, Sep 12, 2005 at 06:00:15PM -0400, Luben Tuikov wrote:
> > "transport attribute class" is just an _attribute_ class, Christoph.
> > "transport layer" is a lot more involved.  I sincerely hope
> > you can see this.  E.g. domain discovery belongs in the transport
> > layer.  In SPI, LLDDs did it; in MPT the firmware does it.
> 
> LLDDs having their own domain discovery code is definitely a misfeature.

Unfortunatly it is impossible to have one discovery code shared by all
LLDD under the same transport -- in FC world, Qlogic does "remote ports"
discovery in FW, Emulex does it in LLDD. Both approaches have benefits
and drawbacks, but it would be hard, if not impossible to move Emulex
discovery code into FC transport and to force Qlogic to use it, because
Qlogic HBA are not designed for doing discovery in the driver.
 But the fact that Qlogic does discovery in FW/ASIC does not turn Qlogic
HBAs into SPI. I expect the same is true in SAS -- even though MPT cards
do discovery on the card, those SAS cards can not masquerade as a SPI
cards (well, in theory, it is possible, but ...).        
 
> As you know, stuff is being rearranged to move more of the SPI-specific
> code from both SCSI core and LLDDs into the SPI transport.  I suspect
> domain discovery will always be triggered by the LLDD for SPI, but at
> least a driver doesn't have to have its own code to do that any more.

Only if it can be turned into a some sort of library LLDD may use if it
needs it. But it is only makes sense to move that code out of the LLDD
and into the transport module, if more then one LLDD can make use of it.

Sergey Panov

======================================================================
Any opinions are personal and not necessarily those of my former,
present, or future employers.



