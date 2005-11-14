Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVKNMlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVKNMlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVKNMlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:41:36 -0500
Received: from gold.veritas.com ([143.127.12.110]:32354 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751111AbVKNMlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:41:35 -0500
Date: Mon, 14 Nov 2005 12:40:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051114123432.GQ20871@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0511141237180.2655@goblin.wat.veritas.com>
References: <20051114122759.GE5492@minantech.com> <20051114123432.GQ20871@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Nov 2005 12:41:28.0941 (UTC) FILETIME=[BBD061D0:01C5E918]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Michael S. Tsirkin wrote:
> Quoting Gleb Natapov <gleb@minantech.com>:
> > On Mon, Nov 14, 2005 at 02:25:35PM +0200, Michael S. Tsirkin wrote:
> > > 
> > > There's one thing that I have thought about: what happens
> > > if I set DONTFORK on a page which already has COW set
> > > (e.g. after fork)?
> > > 
> > > It seems that the right thing would be to force a page copy -
> > > otherwise the page can get copied on write.

No, keep it simple, DONTFORK simply marks the area as not to be included
in a fork from that time onwards (until perhaps a DOFORK follows).

> > I thought about it. It should not happen for OpenIB since get_user_pages
> > will break COW for us and I don't think we should complicate DONTFORK
> > implementation by doing break during madvise().

Exactly.

> Hmm, I assumed we call madvise before driver does get_user_pages,
> otherwise an application could fork in between.

I think we're all of us assuming that.

> Should we worry about this?

About what?

Hugh
