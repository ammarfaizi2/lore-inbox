Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUHTTpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUHTTpk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268696AbUHTTpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:45:39 -0400
Received: from mail.cs.umn.edu ([128.101.34.202]:61114 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S268688AbUHTTpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:45:35 -0400
Date: Fri, 20 Aug 2004 14:45:25 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
       martins@au.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
Message-ID: <20040820194525.GA13970@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk> <20040820142143.GB14144@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820142143.GB14144@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 03:21:43PM +0100, Matthew Wilcox wrote:
> On Sat, Aug 14, 2004 at 07:29:32PM +0100, Matthew Wilcox wrote:
> > Thoughts?  Since there's at least four and probably more ways of getting
> > at VPD, we either need to fill in some VPD structs at initialisation or
> > have some kind of vpd_ops that a driver can fill in so the core can get
> > at the data.
> 
> I've tried the first option -- creating a large block of sysfs entries for
> all the VPD entries that are present.  However, I've come upon a problem
> with sysfs that prevents me from doing so.
> 
> Basically, the problem is that sysfs doesn't pass the attribute that's
> being invoked to the attribute ->show method.  So I can't determine
> which one is being read.  This isn't a problem for any other sysfs attribute
> because they're all static, but for dynamically created attributes, it's
> not possible to work this way.

Ya, I ran into some similar restrictions with a driver I was
writing...after talking to gregkh, you are going to have to go down a
level and use kobjects directly...each piece of data will have a kobject, 
and that's what you dereference in the show method. 

-- 
Dave Boutcher
