Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbUKMAFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUKMAFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUKMADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:03:12 -0500
Received: from mms2.broadcom.com ([63.70.210.59]:46347 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S262739AbUKMABY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:01:24 -0500
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] pci-mmconfig fix for 2.6.9
Date: Fri, 12 Nov 2004 15:56:16 -0800
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3C9E@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: [PATCH] pci-mmconfig fix for 2.6.9
Thread-Index: AcTJB8o2C35CHqdST1uS7snB3oYsEQABgp2w
From: "Michael Chan" <mchan@broadcom.com>
To: "Grant Grundler" <grundler@parisc-linux.org>
cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
X-WSS-ID: 6D8B922A1PO7452725-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004, 15:31:59 -0700, Grant Grundler wrote:

> 
> On Fri, Nov 12, 2004 at 01:49:18PM -0800, Michael Chan wrote:
> > In short, I believe mmconfig is allowed to be posted or 
> non-posted. If 
> > it is posted, there must be a method to allow software to flush it.
> 
> Yes. Agreed.
> But existing direct access methods must implement 
> non-postable writes to be compliant.
> 
> E.g. the second paragraph of the Implementation Note:
> | In those cases in which the software must know that a posted 
> | transaction is completed by the completer, ...
> 
> IMHO, "In those cases" refers to the second class of systems. 
> i386 and x86_64 are (still) in the first class of "legacy" systems.

Hi Grant,

I think we are almost in agreement. IMHO, the entire ECN applies the
PC-compatible systems and any examples in the Implementation Note is a
valid implementation. mmconfig can be posted, as long as there is a way
to guarantee that the write has completed, such as flush by reading. We
disagree on this point.

The Intel mmconfig implementation is non-posted which is a valid
implementation. Therefore readl is unnecessary and can be removed.

Michael

