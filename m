Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHBUTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHBUTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUHBUTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:19:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:26084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263024AbUHBURY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:17:24 -0400
Date: Mon, 2 Aug 2004 13:08:49 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040802200849.GG28374@kroah.com>
References: <20040726144856.GH1231@obelix.in.ibm.com> <20040726173151.A11637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726173151.A11637@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:31:51PM +0100, Christoph Hellwig wrote:
> On Mon, Jul 26, 2004 at 08:18:56PM +0530, Ravikiran G Thirumalai wrote:
> > Greg,
> > Here is a patch to add kref_read and kref_put_last.
> > These primitives were needed to change files_struct.f_count
> > refcounter to use kref api.
> > 
> > kref_put_last is needed sometimes when a refcount might
> > have an unconventional release which needs more than
> > the refcounted object to process object release-- like in the
> > files_struct.f_count conversion patch at __aio_put_req().
> > The following patch depends on kref shrinkage patches.
> > (which you have already included).
> 
> Why don't you simply use an atomic_t if that's what you seem to
> want?

Exactly.  In cases like this, where the user, for some reason, wants to
know the state of the reference count, they should not use a struct
kref.  I'm not going to add these functions to the kref api, sorry.

thanks,

greg k-h
