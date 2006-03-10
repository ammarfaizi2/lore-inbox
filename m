Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752180AbWCJI7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbWCJI7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWCJI7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:59:05 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37079 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1752180AbWCJI7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:59:04 -0500
Date: Fri, 10 Mar 2006 08:59:00 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside (ver. 3)
Message-ID: <20060310085900.GX27946@ftp.linux.org.uk>
References: <44113CCC.5080602@openvz.org> <1141980385.2876.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141980385.2876.30.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:46:25AM +0100, Arjan van de Ven wrote:
> On Fri, 2006-03-10 at 11:46 +0300, Kirill Korotaev wrote:
> > Andrew,
> > 
> > Fixed both comments from Al Viro (thanks, Al):
> > - should have a separate helper
> > - should pass 0 instead of GFP_KERNEL in page_symlink()
> 
> >  
> > +	page = find_or_create_page(mapping, 0,
> > +			mapping_gfp_mask(mapping) | gfp_mask);
> 
> 
> 
> this does not work; GFP_NOFS has a bit *LESS* than GFP_KERNEL, not a bit
> more. As such a | operation isn't going to be useful....
> 
> (So I think that while Al's intention was good, the implication of it
> isn't ;)

s/|/^/ and accept my apologies...
