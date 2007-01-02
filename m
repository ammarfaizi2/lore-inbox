Return-Path: <linux-kernel-owner+w=401wt.eu-S965023AbXABWyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbXABWyE (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbXABWyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:54:03 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:43362 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964998AbXABWyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:54:01 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, davem@davemloft.net,
       arjan@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20070101234559.GE30535@flint.arm.linux.org.uk>
References: <20061230.212338.92583434.davem@davemloft.net>
	 <20061231092318.GA1702@flint.arm.linux.org.uk>
	 <1167557242.20929.647.camel@laptopd505.fenrus.org>
	 <20061231.014756.112264804.davem@davemloft.net>
	 <20061231100007.GC1702@flint.arm.linux.org.uk>
	 <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
	 <20061231173743.GD1702@flint.arm.linux.org.uk>
	 <E1H1VQu-0005oJ-00@dorka.pomaz.szeredi.hu>
	 <20070101234559.GE30535@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 16:53:23 -0600
Message-Id: <1167778403.3687.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-01 at 23:45 +0000, Russell King wrote:
> > However the cache flushing in kmap/kunmap idea might be cleaner and
> > better.
> 
> It has the significant advantage that, unlike the flush* calls, they
> can't really be forgotten by folk programming on cache alias-free
> hardware.  That's a _very_ persuasive argument for this proposed
> interface.

OK, so lets get down to brass tacks and look at the API characteristics.

Some of the issues are:

     1. Should kmap() actually flush all the user spaces? 
     2. Do we need additional hints in to kmap/kunmap?

My initial thought on 1. is no, since by and large we use kmap on pages
that have come to use via an I/O path, so usually they've already had
the user caches made coherent, unless you want do do this via a hint.

For 2. like I said, I coded this on parisc without hints (using the page
table information instead to deduce what type of access the page had
taken) but we could equally well have used hints.

James


