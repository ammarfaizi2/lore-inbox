Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUC3XOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUC3XOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:14:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:21948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261597AbUC3XOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:14:43 -0500
Date: Tue, 30 Mar 2004 15:16:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: maneesh@in.ibm.com, stern@rowland.harvard.edu, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-Id: <20040330151637.6f5a688b.akpm@osdl.org>
In-Reply-To: <20040330230142.GA13571@kroah.com>
References: <20040328063711.GA6387@kroah.com>
	<Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org>
	<20040328123857.55f04527.akpm@osdl.org>
	<20040329210219.GA16735@kroah.com>
	<20040329132551.23e12144.akpm@osdl.org>
	<20040329231604.GA29494@kroah.com>
	<20040329153117.558c3263.akpm@osdl.org>
	<20040330055135.GA8448@in.ibm.com>
	<20040330230142.GA13571@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 30, 2004 at 11:21:35AM +0530, Maneesh Soni wrote:
> >                                                                                 
> > I am not very clear about how the first two behave. Still I can think
> > of a solution within sysfs like this as Alen suggested. But again I am not 
> > very sure if this can be done properly without any races. But anyway I am 
> > trying.
> >                                                                                 
> > 1) backout my patch sysfs-pin-kobject.patch
> 
> I think we need to do this now, as it is not a correct fix, and causes
> more problems than good at this time.

But the patch was correct.  sysfs retains a pointer to the kobject, it
should take a ref on it?

>  I suggest you try to fix the oops
> you were seeing in either another way, or in a way that does not break
> other things :)

Didn't we demonstrate that the code which broke was already broken?  And
that it has other problems regardless of the kobject pinning fix, such as the
userpace-holding-a-file-open-wedges-khubd problem?

Worried that this is all heading in the wrong direction...
