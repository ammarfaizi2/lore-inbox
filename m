Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbUCMBo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 20:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUCMBo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 20:44:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:60080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262975AbUCMBnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 20:43:16 -0500
Date: Fri, 12 Mar 2004 17:41:56 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040313014156.GB10930@kroah.com>
References: <OF6FA69BBA.80AB3A29-ONC1256E55.0070477F-C1256E55.00708AF1@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6FA69BBA.80AB3A29-ONC1256E55.0070477F-C1256E55.00708AF1@de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 09:29:16PM +0100, Martin Schwidefsky wrote:
> 
> 
> 
> 
> Hi Christoph,
> 
> > >  - Replace release function for device structures by kfree. Move struct
> > >    device to the start of struct zfcp_port/zfcp_unit to make it work.
> >
> > That's ugly as hell.  Actually even more ugly.  It's not that ->release
> > is such a performance critical path that you absolutely need to avoid one
> > level of function calls.  So please put a simple wrapper back instead of
> > the horrible casts and suddenly the silly placement restrictions are gone,
> > too.
> 
> That it's ugly is true. But what's important is that it is required to get
> module ref-counting right. The release function is called after the last
> module_put has been done.

Huh?  Is the scsi reference counting logic that messed up?  If so, it
needs to be fixed.

And if so, why does it not show up with all of the other scsi drivers?

thanks,

greg k-h
