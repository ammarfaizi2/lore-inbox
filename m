Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVAOWYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVAOWYi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAOWYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:24:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37812 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262335AbVAOWYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:24:35 -0500
Date: Sat, 15 Jan 2005 22:24:34 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slab.c use of __get_user and sparse
Message-ID: <20050115222434.GO26051@parcelfarce.linux.theplanet.co.uk>
References: <20050115213906.GA22486@mars.ravnborg.org> <20050115220151.GA16442@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115220151.GA16442@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 11:01:51PM +0100, Andi Kleen wrote:
> > Based on the comment it is understood that suddenly this pointer points
> > to userspace, because the module got unloaded.
> > I wonder why we can rely on the same address now the module got unloaded -
> > we may risk this virtual address is taken over by someone else?
> 
> The address is not user space; you would be lying.
> 
> Perhaps it's best to get rid of the hack completely. Turn kmem_cache_t->name
> into an array and copy the name instead of storing the pointer, then
> it wouldn't be needed at all.

Alternatively, we could provide a new primitive -

size_t safe_memcpy(void *to, void *from, size_t size);

Semantics: copy byte-by-byte until we either get 'size' bytes or trigger an
exception.  Return the number of bytes copied.

Obvious implementation via __get_user() would be default, overridable by
architecture...
