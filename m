Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUBDSB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUBDSB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:01:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:63887 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263513AbUBDSBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:01:25 -0500
Date: Wed, 4 Feb 2004 10:01:07 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>, greg KH <gregkh@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 probe.c "pcibus_class" Device Class, release function
Message-ID: <20040204180107.GB11614@kroah.com>
References: <1075847619.28337.31.camel@verve> <40204B7E.6030408@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40204B7E.6030408@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 05:31:42PM -0800, Matthew Dobson wrote:
> John Rose wrote:
> >The function release_pcibus_dev() in probe.c defines the release procedure 
> >for
> >device class pcibus_class.  I want to suggest that this function be 
> >scrapped :)
> >
> >This release function is called in the code path of 
> >class_device_unregister().
> >The pcibus_class devices aren't currently unregistered anywhere, from what 
> >I
> >can tell, so this release function is currently unused.  The runtime 
> >removal of
> >PCI buses from logical partitions on PPC64 requires the unregistration of 
> >these
> >class devices.  The natural place to do this IMHO is in 
> >pci_remove_bus_device()
> >in remove.c.  
> 
> You're right that the class device isn't currently unregistered, and 
> that was an oversight in the patch I originally sent.  Attatched is a 
> patch that remedies that situation.  pci_remove_bus_device() *is* the 
> natural place to unregister the class_dev, and that's just what the 
> patch does.

Thanks, I've applied this patch to my trees and will send off to Linus
in the next round of PCI patches.

greg k-h
