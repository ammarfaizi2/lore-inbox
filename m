Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWCTR1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWCTR1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 12:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWCTR1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 12:27:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:26259 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932372AbWCTR1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 12:27:35 -0500
Date: Mon, 20 Mar 2006 09:27:02 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Stone Wang <pwstone@gmail.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced
 mlock-LRU semantic
In-Reply-To: <bc56f2f0603200535s2b801775m@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603200923560.24138@schroedinger.engr.sgi.com>
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, Stone Wang wrote:

> 2. More consistent LRU semantics in Memory Management.
>    Mlocked pages is placed on a separate LRU list: Wired List.
>    The pages dont take part in LRU algorithms,for they could never be swapped,
>    until munlocked.

This also implies that dirty bits of the pte for mlocked pages are never 
checked. 

Currently light swapping (which is very common) will scan over all pages 
and move the dirty bits from the pte into struct page. This may take 
awhile but at least at some point we will write out dirtied pages.

The result of not scanning mlocked pages will be that mmapped files will 
not be updated unless either the process terminates or msync() is called.

