Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbUC3ACD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbUC3ACD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:02:03 -0500
Received: from mail.kroah.org ([65.200.24.183]:60837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263215AbUC3AB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:01:58 -0500
Date: Mon, 29 Mar 2004 16:01:29 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, viro@math.psu.edu,
       maneesh@in.ibm.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040330000129.GA31667@kroah.com>
References: <20040328063711.GA6387@kroah.com> <Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org> <20040328123857.55f04527.akpm@osdl.org> <20040329210219.GA16735@kroah.com> <20040329132551.23e12144.akpm@osdl.org> <20040329231604.GA29494@kroah.com> <20040329153117.558c3263.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329153117.558c3263.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:31:17PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > The module should remain in memory, "unhashed", until the final kobject
> > > reference falls to zero.  Destruction of that kobject causes the refcount
> > > on the module to fall to zero which causes the entire module to be
> > > released.
> > > 
> > > (hmm, the existence of a kobject doesn't appear to contribute to its
> > > module's refcount.  Why not?)
> > 
> > It does, if a file for that kobject is opened.  In this case, there was
> > no file opened, so the module refcount isn't incremented.
> 
> hm, surprised.  Shouldn't the existence of a kobject contribute to its
> module's refcount?

No, a kobject by itself knows nothing about a module.  Only the
attribute files do (and they are the things that contain the struct
module *), as they are what user space can grab references to.

I never thought that the kobject would care, as it is only a directory,
and I didn't think that anything could grab directory references on
their own.  But then Maneesh's patch wasn't in the kernel at that time
:)

thanks,

greg k-h
