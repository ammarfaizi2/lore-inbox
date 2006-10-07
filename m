Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWJGAPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWJGAPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 20:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWJGAPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 20:15:43 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38756 "EHLO
	pd3mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932667AbWJGAPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 20:15:42 -0400
Date: Fri, 06 Oct 2006 18:15:36 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2/2] [TULIP] Check the return value from pci_set_mwi()
In-reply-to: <fa.lMwhGlM7h3gT94gAUyYURPCF1Qg@ifi.uio.no>
To: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>
Message-id: <4526F1A8.3020907@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.5vbPpPQ5p6Rqb6w5IQvYeIEZ+o4@ifi.uio.no>
 <fa.5fHFiSyxiA8IzX/z36b4ccRdkwk@ifi.uio.no>
 <fa.xexLYpZ2s3jlzi3H4j8CMu5nU5M@ifi.uio.no>
 <fa.DScE5F/ioZsTJQxVaKgCvzyY/+o@ifi.uio.no>
 <fa.lMwhGlM7h3gT94gAUyYURPCF1Qg@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The unmodified tulip driver checks both MWI and cacheline-size because 
> one of the clones (PNIC or PNIC2) will let you set the MWI bit, but 
> hardwires cacheline size to zero.
> 
> If the arches do not behave consistently, we need to keep the check in 
> the tulip driver, to avoid incorrectly programming the csr0 MWI bit.
> 
>     Jeff

I should think that pci_set_mwi should fail if either the cache line 
size showed 0 (after either setting the correct size or assuming it 
should have been set already) or the MWI bit ended up clear after we 
tried to turn it on.

That pcibios_prep_mwi code for sparc64 looks wrong, if you plug in a 
device that doesn't implement MWI at all it will probably not let 
anything get written to PCI_CACHE_LINE_SIZE other than 0, but it is 
blindly succeeding in all cases. Even if the arch assumes the firmware 
already set the size properly it should still make sure it is non-zero 
before allowing MWI..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

