Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVCAUzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVCAUzP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbVCAUq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:46:56 -0500
Received: from mail.kroah.org ([69.55.234.183]:21191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262069AbVCAUp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:45:59 -0500
Date: Tue, 1 Mar 2005 12:15:29 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New operation for kref to help avoid locks
Message-ID: <20050301201528.GA23484@kroah.com>
References: <42209BFD.8020908@acm.org> <20050226232026.5c12d5b0.vsu@altlinux.ru> <4220F6C8.4020002@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4220F6C8.4020002@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 04:23:04PM -0600, Corey Minyard wrote:
> Add a routine to kref that allows the kref_put() routine to be
> unserialized even when the get routine attempts to kref_get()
> an object without first holding a valid reference to it.  This is
> useful in situations where this happens multiple times without
> freeing the object, as it will avoid having to do a lock/semaphore
> except on the final kref_put().
> 
> This also adds some kref documentation to the Documentation
> directory.

I like the first part of the documentation, that's nice.

But I don't like the new kref_get_with_check() function that you
implemented.  If you look in the -mm tree, kref_put() now returns if
this was the last put on the reference count or not, to help with lists
of objects with a kref in it.

Perhaps you can use that to implement what you need instead?

thanks,

greg k-h
