Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUC2X3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUC2X3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:29:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:24706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263177AbUC2X3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:29:21 -0500
Date: Mon, 29 Mar 2004 15:31:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: stern@rowland.harvard.edu, david-b@pacbell.net, viro@math.psu.edu,
       maneesh@in.ibm.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-Id: <20040329153117.558c3263.akpm@osdl.org>
In-Reply-To: <20040329231604.GA29494@kroah.com>
References: <20040328063711.GA6387@kroah.com>
	<Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org>
	<20040328123857.55f04527.akpm@osdl.org>
	<20040329210219.GA16735@kroah.com>
	<20040329132551.23e12144.akpm@osdl.org>
	<20040329231604.GA29494@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > The module should remain in memory, "unhashed", until the final kobject
> > reference falls to zero.  Destruction of that kobject causes the refcount
> > on the module to fall to zero which causes the entire module to be
> > released.
> > 
> > (hmm, the existence of a kobject doesn't appear to contribute to its
> > module's refcount.  Why not?)
> 
> It does, if a file for that kobject is opened.  In this case, there was
> no file opened, so the module refcount isn't incremented.

hm, surprised.  Shouldn't the existence of a kobject contribute to its
module's refcount?

> > Maybe a shrink_dcache_parent(dentry) on entry to simple_rmdir() would
> > suffice?
> 
> Will that get rid of the references properly nwhen we remove the
> kobject?

That's one the dcache guys could address better, but I was mainly proposing
it as a way of removing any negative dentries.  But it appears that we have
problems beyond negative dentries?
