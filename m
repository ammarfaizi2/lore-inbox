Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVCAV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVCAV2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCAV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:28:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:51672 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262043AbVCAVZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:25:24 -0500
Date: Tue, 1 Mar 2005 13:24:35 -0800
From: Greg KH <greg@kroah.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Corey Minyard <minyard@acm.org>, Sergey Vlasov <vsu@altlinux.ru>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New operation for kref to help avoid locks
Message-ID: <20050301212435.GA24531@kroah.com>
References: <42209BFD.8020908@acm.org> <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org> <20050301201528.GA23484@kroah.com> <1109710964.6293.166.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109710964.6293.166.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 10:02:43PM +0100, Arjan van de Ven wrote:
> On Tue, 2005-03-01 at 12:15 -0800, Greg KH wrote:
> > On Sat, Feb 26, 2005 at 04:23:04PM -0600, Corey Minyard wrote:
> > > Add a routine to kref that allows the kref_put() routine to be
> > > unserialized even when the get routine attempts to kref_get()
> > > an object without first holding a valid reference to it.  This is
> > > useful in situations where this happens multiple times without
> > > freeing the object, as it will avoid having to do a lock/semaphore
> > > except on the final kref_put().
> > > 
> > > This also adds some kref documentation to the Documentation
> > > directory.
> > 
> > I like the first part of the documentation, that's nice.
> > 
> > But I don't like the new kref_get_with_check() function that you
> > implemented.  If you look in the -mm tree, kref_put() now returns if
> > this was the last put on the reference count or not, to help with lists
> > of objects with a kref in it.
> > 
> > Perhaps you can use that to implement what you need instead?
> 
> note that I'm not convinced the "lockless" implementation actually is
> faster. It still uses an atomic variable, which is just as expensive as
> taking a lock normally...

I have never stated it would be "faster" that I know of, and you still
need a lock to protect some of the paths.  But that is documented in my
2004 ols paper about kref.

thanks,

greg k-h
