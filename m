Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVF2UvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVF2UvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVF2UvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:51:11 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9095 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262632AbVF2Us1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:48:27 -0400
Date: Wed, 29 Jun 2005 15:48:23 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
Message-ID: <20050629204823.GM28499@austin.ibm.com>
References: <20050628235919.GA6415@austin.ibm.com> <1120009868.5133.232.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120009868.5133.232.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:51:07AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Tue, 2005-06-28 at 18:59 -0500, Linas Vepstas wrote:
> > pci-err-7-symbios.patch
> > 
> > Adds PCI Error recoervy callbacks to the Symbios Sym53c8xx driver.
> > Tested, seems to work well under i/o stress to one disk. Not
> > stress tested under heavy i/o to multiple scsi devices.
> > 
> > Note the check of the pci error state flag inside an infinite
> > loop inside the interrupt handler. Without this check, the 
> > device can spin forever, locking up hard, long before the 
> > asynchronous error event (and callbacks) are ever called. 
> 
> Normally, you should check for non-responding hardware by testing things
> like reading all ff's or having a timeout in the loop. 

For ppc64, that does happen in the loop, and so the flag does get
set synchronously, even on a single-cpu system.  But point taken.

> The bug is that
> the driver has a potential infinite loop in the first place.
> 
> The only type of "synchronous" error checking that can be done is what
> is proposed by Hidetoshi Seto. You could use his stuff here.

Yes. However, I will leave this bit in for now, (and mark it as a hack) 
until Seto-san's patches are on deck. I'd rather not have a built-in 
pre-req right now.

--linas
