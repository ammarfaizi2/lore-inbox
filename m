Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVBIJO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVBIJO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVBIJO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:14:27 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:21766 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261597AbVBIJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:14:12 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <Xine.LNX.4.44.0502081906290.1862-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502081906290.1862-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Feb 2005 10:14:09 +0100
Message-Id: <1107940449.14810.12.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 19:09 -0500, James Morris wrote:
> On Wed, 9 Feb 2005, Fruhwirth Clemens wrote:
> 
> > > You can't call kmap() in softirq context (why was it even trying?):
> > 
> > Why not? What's the alternative, then?
> 
> It can sleep in map_new_virtual().
> 
> The alternative is to use atomic kmaps.  For this code, unless you can 
> point to something concrete in the existing kernel which would benefit 
> from passing an arbitrary number of scatterlists in, just code for the 
> case of processing two at once (input & output).

kmap_atomic doesn't qualify as alternative. It's limited to two free
mappings. There must be something else to kmap in softirq. I really
can't imagine such a limitation.

Where is the documentation for the highmem stuff anyway? It's stunning
that there is not a single useful hit in ./Documentation for kmap_atomic
or kmap. The web is also close-lipped about that issue.

I can't code for the case of two. Because, first, that's the idea of
generic in the name "generic scatterwalk", second, I need at least 3
scatterlists in parallel for LRW.

-- 
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org
