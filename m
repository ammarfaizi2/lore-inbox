Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWCUFXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWCUFXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWCUFXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:23:09 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:6311 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030324AbWCUFXI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:23:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IDKxeA/BggWGiJ11pbA3Uyf5PZ7bFmFo7+HoDk9vf8OnkSV72jEFk9nfNoznDoG4vfYIVNch2rU6yra+3HLSVxjrUIp+ROHegC3WzVwMWNO/qViI3/QGwuWTI/eQO99SMNGm8vnHU4NWR38RRnVl8NsDvdKy8p83EBjy5OUBykE=
Message-ID: <bc56f2f0603202123o1f43132u@mail.gmail.com>
Date: Tue, 21 Mar 2006 00:23:06 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced mlock-LRU semantic
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.64.0603200923560.24138@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
	 <Pine.LNX.4.64.0603200923560.24138@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will check and fix it.

2006/3/20, Christoph Lameter <clameter@sgi.com>:
> On Mon, 20 Mar 2006, Stone Wang wrote:
>
> > 2. More consistent LRU semantics in Memory Management.
> >    Mlocked pages is placed on a separate LRU list: Wired List.
> >    The pages dont take part in LRU algorithms,for they could never be swapped,
> >    until munlocked.
>
> This also implies that dirty bits of the pte for mlocked pages are never
> checked.
>
> Currently light swapping (which is very common) will scan over all pages
> and move the dirty bits from the pte into struct page. This may take
> awhile but at least at some point we will write out dirtied pages.
>
> The result of not scanning mlocked pages will be that mmapped files will
> not be updated unless either the process terminates or msync() is called.
>
>
