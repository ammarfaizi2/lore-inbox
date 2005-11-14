Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVKNM2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVKNM2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVKNM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:28:44 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:6166 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1751108AbVKNM2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:28:43 -0500
Date: Mon, 14 Nov 2005 14:27:59 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051114122759.GE5492@minantech.com>
References: <Pine.LNX.4.61.0511101251060.7127@goblin.wat.veritas.com> <20051114122535.GP20871@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114122535.GP20871@mellanox.co.il>
X-OriginalArrivalTime: 14 Nov 2005 12:28:42.0508 (UTC) FILETIME=[F2FBFCC0:01C5E916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> Quoting Hugh Dickins <hugh@veritas.com>:
> > Subject: Re: Nick's core remove PageReserved broke vmware...
> > 
> > On Tue, 8 Nov 2005, Michael S. Tsirkin wrote:
> > > 
> > > Hugh, did you have something like the following in mind
> > > (this is only boot-tested and only on x86-64)?
> > 
> > Yes, that looks pretty good to me, a few comments below.
> > Only another twenty or so architectures to go ;)
> 
> There's one thing that I have thought about: what happens
> if I set DONTFORK on a page which already has COW set
> (e.g. after fork)?
> 
> It seems that the right thing would be to force a page copy -
> otherwise the page can get copied on write.
> 
I thought about it. It should not happen for OpenIB since get_user_pages
will break COW for us and I don't think we should complicate DONTFORK
implementation by doing break during madvise().

--
			Gleb.
