Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTFEQLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbTFEQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 12:11:19 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:60822 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264732AbTFEQLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 12:11:17 -0400
Date: Thu, 5 Jun 2003 17:29:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Morris <jmorris@intercode.com.au>
Cc: pam.delaney@lsil.com, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for MPT Fusion driver for 2.5.70 bk
Message-ID: <20030605162901.GA7035@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Morris <jmorris@intercode.com.au>, pam.delaney@lsil.com,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <Mutt.LNX.4.44.0306060154230.2735-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0306060154230.2735-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 02:01:22AM +1000, James Morris wrote:
 > The patch below fixes compilation for the MPT Fusion driver, which broke 
 > with recent changes to the PCI API.
 > 
 > It seems that the code is trying to detect which version of the API its 
 > being compiled for, but the macro it was looking for has disappeared.

This looks bogus to me.

 > diff -urN -X dontdiff bk.pending/drivers/message/fusion/linux_compat.h bk.w1/drivers/message/fusion/linux_compat.h
 > --- bk.pending/drivers/message/fusion/linux_compat.h	2003-06-06 00:36:11.000000000 +1000
 > +++ bk.w1/drivers/message/fusion/linux_compat.h	2003-06-06 01:48:49.000000000 +1000
 > @@ -147,7 +147,7 @@
 >  
 >  
 >  /* PCI/driver subsystem { */
 > -#ifndef pci_for_each_dev
 > +#ifndef pci_for_each_dev_reverse
 >  #define pci_for_each_dev(dev)		for((dev)=pci_devices; (dev)!=NULL; (dev)=(dev)->next)

What has _reverse got to do with this define ?

Whilst on the subject, how come we still have the _reverse method now
that pci_for_each_dev is dead ?

		Dave

