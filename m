Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWIGNbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWIGNbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWIGNbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:31:38 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25493 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932107AbWIGNbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:31:36 -0400
Message-ID: <45001EE3.1070500@garzik.org>
Date: Thu, 07 Sep 2006 09:30:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Tejun Heo <htejun@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com> <20060907130401.GO2558@parisc-linux.org>
In-Reply-To: <20060907130401.GO2558@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Sep 07, 2006 at 02:53:57PM +0200, Tejun Heo wrote:
>> The spec says that devices can put additional restriction on supported 
>> cacheline size (IIRC, the example was something like power of two >= or 
>> <= certain size) and should ignore (treat as zero) if unsupported value 
>> is written.  So, there might be need for more low level driver 
>> involvement which knows device restrictions, but I don't know whether 
>> such devices exist.
> 
> That's nothing we can do anything about.  The system cacheline size is
> what it is.  If the device doesn't support it, we can't fall back to a
> different size, it'll cause data corruption.  So we'll just continue on,
> and devices which live up to the spec will act as if we hadn't
> programmed a cache size.  For devices that don't, we'll have the quirk.
> 
> Arguably devices which don't support the real system cacheline size
> would only get data corruption if they used MWI, so we only have to
> prevent them from using MWI; they could use a different cacheline size
> for MRM and MRL without causing data corruption.  But I don't think we
> want to go down that route; do you?

FWIW, there are definitely both ethernet and SATA PCI devices which only 
allow a limited set of values in the cacheline size register... and that 
limited set does not include some of the modern machines.

	Jeff



