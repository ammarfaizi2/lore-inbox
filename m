Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUC3HeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263329AbUC3HeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:34:13 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15053 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262580AbUC3HeC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:34:02 -0500
Date: Tue, 30 Mar 2004 13:08:30 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040330073830.GB8448@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org> <20040330000129.GA31667@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330000129.GA31667@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 04:01:29PM -0800, Greg KH wrote:
> On Mon, Mar 29, 2004 at 03:31:17PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > > The module should remain in memory, "unhashed", until the final kobject
> > > > reference falls to zero.  Destruction of that kobject causes the refcount
> > > > on the module to fall to zero which causes the entire module to be
> > > > released.
> > > > 
> > > > (hmm, the existence of a kobject doesn't appear to contribute to its
> > > > module's refcount.  Why not?)
> > > 
> > > It does, if a file for that kobject is opened.  In this case, there was
> > > no file opened, so the module refcount isn't incremented.
> > 
> > hm, surprised.  Shouldn't the existence of a kobject contribute to its
> > module's refcount?
> 
> No, a kobject by itself knows nothing about a module.  Only the
> attribute files do (and they are the things that contain the struct
> module *), as they are what user space can grab references to.
> 
> I never thought that the kobject would care, as it is only a directory,
> and I didn't think that anything could grab directory references on
> their own.  But then Maneesh's patch wasn't in the kernel at that time
> :)
> 

I don't how fisible is it to move the owner field to the kobject and keep the
module and kobject both alive as long as there are sysfs directories referring
to them.

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
