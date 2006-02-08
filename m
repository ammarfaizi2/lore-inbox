Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWBHRFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWBHRFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbWBHRFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:05:52 -0500
Received: from verein.lst.de ([213.95.11.210]:63366 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1161119AbWBHRFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:05:51 -0500
Date: Wed, 8 Feb 2006 18:05:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Horst Hummel <horst.hummel@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Martin <mschwid2@de.ibm.com>,
       kernel <linux-kernel@vger.kernel.org>,
       Stefan Weinhuber <wein@de.ibm.com>, heiko <heicars2@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 05/10] s390: add missing validation for dasd discipline specific ioctls
Message-ID: <20060208170541.GA20029@lst.de>
References: <1139417819.5945.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139417819.5945.16.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 05:56:59PM +0100, Horst Hummel wrote:
> Christoph Hellwig <hch@lst.de> wrote on 08.02.2006 15:08:39:
> 
> > On Wed, Feb 08, 2006 at 01:37:09PM +0100, Heiko Carstens wrote:
> > > From: Horst Hummel <horst.hummel@de.ibm.com>
> > > 
> > > Because of missing discipline validition dasd ioctls calls may not
> return
> > > when called on a device handled by a different discipline.
> > > (e.g calling ECKD specific BIODASDGATTR on an FBA device).
> > > This addresses one of the issues Christoph has with the dasd driver.
> > 
> > Nack.  the right way to do this is to have per-discipline ioctl
> methods,
> > even if we can't remove the dasd_ioctl_register interface yet due to
> > other disagreements.  Just resurect those parts of my patch.
> > 
> As I already tried to explain, the DASD ioctls are _not_ discipline
> related. A discipline is more or less a 'access method to a physical 
> DASD'. Sine the ioctls are related to 'functional components', each
> ioctl could be valid in combination with none, one, two or every of
> the currently supported disciplines (ECKD, FBA, DIAG).

Right now there's either ioctls that are valid for one (ECKD) or all
disciplines.   As a special case you've put ioctls that are valid for
all disciplines into odd modules, but that's just another case of lots
of crap in s390 drivers that needs sorting out.
