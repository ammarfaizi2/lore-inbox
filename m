Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVKNMl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVKNMl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVKNMl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:41:56 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:8983 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751113AbVKNMlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:41:55 -0500
Date: Mon, 14 Nov 2005 14:41:11 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114124111.GF5492@minantech.com>
References: <20051114122759.GE5492@minantech.com> <20051114123432.GQ20871@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114123432.GQ20871@mellanox.co.il>
X-OriginalArrivalTime: 14 Nov 2005 12:41:54.0252 (UTC) FILETIME=[CAE688C0:01C5E918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:34:32PM +0200, Michael S. Tsirkin wrote:
> Quoting Gleb Natapov <gleb@minantech.com>:
> > Subject: Re: Nick's core remove PageReserved broke vmware...
> > 
> > On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> > > Quoting Hugh Dickins <hugh@veritas.com>:
> > > > Subject: Re: Nick's core remove PageReserved broke vmware...
> > > > 
> > > > On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> > > > > 
> > > > > Hugh, did you have something like the following in mind
> > > > > (this is only boot-tested and only on x86-64)?
> > > > 
> > > > Yes, that looks pretty good to me, a few comments below.
> > > > Only another twenty or so architectures to go ;)
> > > 
> > > There's one thing that I have thought about: what happens
> > > if I set DONTFORK on a page which already has COW set
> > > (e.g. after fork)?
> > > 
> > > It seems that the right thing would be to force a page copy -
> > > otherwise the page can get copied on write.
> >
> > I thought about it. It should not happen for OpenIB since get_user_pages
> > will break COW for us and I don't think we should complicate DONTFORK
> > implementation by doing break during madvise().
> 
> Hmm, I assumed we call madvise before driver does get_user_pages,
> otherwise an application could fork in between.
> Should we worry about this?
> 
OK, we set VM_DONTFORK on vma and than driver calls get_user_pages()
that actually do page table walking and COW breaking. Or do I miss
something here?

--
			Gleb.
