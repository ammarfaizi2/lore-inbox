Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVHKN64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVHKN64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 09:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVHKN64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 09:58:56 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:32625 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030309AbVHKN64 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 09:58:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMLM2wYsc5wRHInY3s0WIK2zgP2PGl57kfjPhN5uUjnC4kjBWrmDbuicmsRWanoQiP3QvXnRkDBnKXbn/ukwqteKkcHsBRjLc1ByVieywAulzi/DhCJZxFsoi5thq9AU9Zqj5yELPzA3qqHgoDAtwX2g6V4ixGhIxF9vlLXvv0I=
Message-ID: <84144f0205081106586eb0d5cf@mail.gmail.com>
Date: Thu, 11 Aug 2005 16:58:54 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch 6/7] mm: lockless pagecache
Cc: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42FB4454.2010601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>
	 <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>
	 <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>
	 <42FB4454.2010601@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 8/11/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> +unsigned find_get_pages_nonatomic(struct address_space *mapping, pgoff_t start,
> +                           unsigned int nr_pages, struct page **pages)
> +{
> +       unsigned int i;
> +       unsigned int ret;

Rename to nr_pages?

> +       unsigned int ret2;

Rename to ret?

> +
> +       /*
> +        * We do some unsightly casting to use the array first for storing
> +        * pointers to the page pointers, and then for the pointers to
> +        * the pages themselves that the caller wants.
> +        */
> +       rcu_read_lock();
> +       ret = radix_tree_gang_lookup_slot(&mapping->page_tree,
> +                               (void ***)pages, start, nr_pages);
> +       ret2 = 0;
> +       for (i = 0; i < ret; i++) {

Pretty please? :-)

                                  Pekka
