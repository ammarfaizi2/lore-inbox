Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWJJTPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWJJTPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWJJTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:15:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:2997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932251AbWJJTPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:15:13 -0400
Date: Tue, 10 Oct 2006 12:14:18 -0700
From: Greg KH <greg@kroah.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       Michael Krufky <mkrufky@linuxtv.org>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, stable@kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 07/19] invalidate_complete_page() race fix
Message-ID: <20061010191418.GB11171@kroah.com>
References: <20061010165621.394703368@quad.kroah.org> <20061010171451.GH6339@kroah.com> <Pine.LNX.4.64.0610101909450.18380@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610101909450.18380@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 07:12:54PM +0100, Hugh Dickins wrote:
> On Tue, 10 Oct 2006, Greg KH wrote:
> 
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > If a CPU faults this page into pagetables after invalidate_mapping_pages()
> > checked page_mapped(), invalidate_complete_page() will still proceed to remove
> > the page from pagecache.  This leaves the page-faulting process with a
> > detached page.  If it was MAP_SHARED then file data loss will ensue.
> > 
> > Fix that up by checking the page's refcount after taking tree_lock.
> 
> I may have lost the plot, but I think this patch has already proved
> to cause problems for NFS in 2.6.18: not good to put it into 2.6.17
> stable while it's awaiting refinement for 2.6.18 stable.

Ok, I've dropped it now.

thanks,

greg k-h
