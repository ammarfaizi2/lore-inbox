Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWEBFXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWEBFXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 01:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWEBFXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 01:23:44 -0400
Received: from soundwarez.org ([217.160.171.123]:20370 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932367AbWEBFXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 01:23:44 -0400
Date: Tue, 2 May 2006 07:23:41 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Michael Holzheu <holzheu@de.ibm.com>,
       akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060502052341.GD11150@vrfy.org>
References: <20060428112225.418cadd9.holzheu@de.ibm.com> <20060429075311.GB1886@kroah.com> <8A7D2F4D-5A05-4C93-B514-03268CAA9201@mac.com> <20060429215501.GA9870@kroah.com> <4237705F-E1B2-46CF-BE66-EFB77F68EC42@mac.com> <20060501203815.GE19423@kroah.com> <2DBA690E-B11A-478E-B2E0-0529F4CE45A9@mac.com> <20060502040053.GA14413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502040053.GA14413@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 09:00:53PM -0700, Greg KH wrote:
> On Mon, May 01, 2006 at 07:29:23PM -0400, Kyle Moffett wrote:
> > On May 1, 2006, at 16:38:15, Greg KH wrote:
> > >On Sun, Apr 30, 2006 at 01:18:46AM -0400, Kyle Moffett wrote:
> > >>On Apr 29, 2006, at 17:55:01, Greg KH wrote:
> > >>>relayfs is for that.  You can now put relayfs files in any ram  
> > >>>based file system (procfs, ramfs, sysfs, debugfs, etc.)
> > >>
> > >>But you can't twiddle relayfs with echo and cat; it's more suited  
> > >>to high-bandwidth transfers than anything else, no?
> > >
> > >Yes.
> > 
> > So my question stands:  What is the _recommended_ way to handle  
> > simple data types in low-bandwidth/frequency multiple-valued  
> > transactions to hardware?  Examples include reading/modifying  
> > framebuffer settings (currently done through IOCTLS), s390 current  
> > state (up for discussion), etc.  In these cases there needs to be an  
> > atomic snapshot or write of multiple values at the same time.  Given  
> > the situation it would be _nice_ to use sysfs so the admin can do it  
> > by hand; makes things shell scriptable and reduces the number of  
> > binary compatibility issues.
> 
> I really don't know of a way to use sysfs for this currently, and hence,
> am not complaining too much about the different /proc files that have
> this kind of information in it at the moment.
> 
> If you or someone else wants to come up with some kind of solution for
> it, I'm sure that many people would be very happy to see it.

If the count of values handled in a transaction is not to high and it
makes sense to group these values logically, why not just create an
attribute group for every transaction, which creates dummy attributes
to fill the values in, and use an "action" file in that group, that
commits all the values at once to whatever target? That should fit into
the ioctl use pattern, right?

Kay
