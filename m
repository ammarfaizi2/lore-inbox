Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUCaCTn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUCaCTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:19:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:50376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261654AbUCaCTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:19:42 -0500
Date: Tue, 30 Mar 2004 18:19:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: greg@kroah.com, torvalds@osdl.org, maneesh@in.ibm.com,
       stern@rowland.harvard.edu, david-b@pacbell.net, viro@math.psu.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] back out sysfs reference count change
Message-Id: <20040330181915.401b8a04.akpm@osdl.org>
In-Reply-To: <1080699090.1198.117.camel@gaston>
References: <20040328063711.GA6387@kroah.com>
	<Pine.LNX.4.44L0.0403281057100.17150-100000@netrider.rowland.org>
	<20040328123857.55f04527.akpm@osdl.org>
	<20040329210219.GA16735@kroah.com>
	<20040329132551.23e12144.akpm@osdl.org>
	<20040329231604.GA29494@kroah.com>
	<20040329153117.558c3263.akpm@osdl.org>
	<20040330055135.GA8448@in.ibm.com>
	<20040330230142.GA13571@kroah.com>
	<20040330235533.GA9018@kroah.com>
	<1080699090.1198.117.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  I think that the bug in the first place is to have an existing
>  kobject that didn't bump the module ref count.
> 
>  If a kobject exists that have a pointer to the module code (the
>  release function), it _MUST_ have bumped the module ref count,
>  that's the whole point of the module reference count.
> 
>  If rmmod blocks forever because that kobject has a stale reference,
>  that's a different problem, but khubd should not be involved in
>  that process and should definitely not be blocked and not wait for
>  the kobject to go away.

Amen, Brother Ben.  I think the hangup here is that lsmod would show module
refcounts of 2,417.  So for cosmetic reasons, the kobject should take a ref
against an intermediate kref, which has a single ref on the module.

But it looks like that's all in a faraway perfect world, and Greg is going
to fix stuff up somehow ;)

