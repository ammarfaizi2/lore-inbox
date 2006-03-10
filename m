Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWCJJkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWCJJkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 04:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWCJJkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 04:40:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56211 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751982AbWCJJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 04:40:33 -0500
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations
	inside (ver. 3)
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrey Savochkin <saw@saw.sw.com.sg>
In-Reply-To: <20060310085900.GX27946@ftp.linux.org.uk>
References: <44113CCC.5080602@openvz.org>
	 <1141980385.2876.30.camel@laptopd505.fenrus.org>
	 <20060310085900.GX27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 10:40:29 +0100
Message-Id: <1141983630.2876.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 08:59 +0000, Al Viro wrote:
> On Fri, Mar 10, 2006 at 09:46:25AM +0100, Arjan van de Ven wrote:
> > On Fri, 2006-03-10 at 11:46 +0300, Kirill Korotaev wrote:
> > > Andrew,
> > > 
> > > Fixed both comments from Al Viro (thanks, Al):
> > > - should have a separate helper
> > > - should pass 0 instead of GFP_KERNEL in page_symlink()
> > 
> > >  
> > > +	page = find_or_create_page(mapping, 0,
> > > +			mapping_gfp_mask(mapping) | gfp_mask);
> > 
> > 
> > 
> > this does not work; GFP_NOFS has a bit *LESS* than GFP_KERNEL, not a bit
> > more. As such a | operation isn't going to be useful....
> > 
> > (So I think that while Al's intention was good, the implication of it
> > isn't ;)
> 
> s/|/^/ and accept my apologies...

I think you mean
& ~() 

since xor... can flip it on if it was off after all

