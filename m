Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbVKNMcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbVKNMcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVKNMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:32:41 -0500
Received: from [194.90.237.34] ([194.90.237.34]:44252 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1751110AbVKNMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:32:40 -0500
Date: Mon, 14 Nov 2005 14:34:32 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Gleb Natapov <gleb@minantech.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114123432.GQ20871@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051114122759.GE5492@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114122759.GE5492@minantech.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gleb Natapov <gleb@minantech.com>:
> Subject: Re: Nick's core remove PageReserved broke vmware...
> 
> On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> > Quoting Hugh Dickins <hugh@veritas.com>:
> > > Subject: Re: Nick's core remove PageReserved broke vmware...
> > > 
> > > On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> > > > 
> > > > Hugh, did you have something like the following in mind
> > > > (this is only boot-tested and only on x86-64)?
> > > 
> > > Yes, that looks pretty good to me, a few comments below.
> > > Only another twenty or so architectures to go ;)
> > 
> > There's one thing that I have thought about: what happens
> > if I set DONTFORK on a page which already has COW set
> > (e.g. after fork)?
> > 
> > It seems that the right thing would be to force a page copy -
> > otherwise the page can get copied on write.
>
> I thought about it. It should not happen for OpenIB since get_user_pages
> will break COW for us and I don't think we should complicate DONTFORK
> implementation by doing break during madvise().

Hmm, I assumed we call madvise before driver does get_user_pages,
otherwise an application could fork in between.
Should we worry about this?

-- 
MST
