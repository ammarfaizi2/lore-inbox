Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTKZET4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 23:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTKZET4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 23:19:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:53636 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbTKZETz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 23:19:55 -0500
Date: Tue, 25 Nov 2003 20:25:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: riel@redhat.com, steiner@sgi.com, anton@samba.org, jes@trained-monkey.org,
       viro@math.psu.edu, linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-Id: <20031125202545.7a4ca5d3.akpm@osdl.org>
In-Reply-To: <20031126035953.GF8039@holomorphy.com>
References: <20031125231108.GA5675@sgi.com>
	<Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com>
	<20031126035953.GF8039@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> Speaking of which, no one's bothered fixing the X crashes on i386
> discontigmem. Untested patch below.
> 
> ...
> -#define pfn_valid(pfn)          ((pfn) < num_physpages)
> +#define pfn_valid(pfn)							\
> +({									\
> +	unsigned long __pfn__ = pfn;					\
> +	u8 __nid__ = pfn_to_nid(__pfn__);				\
> +	pg_data_t *__pgdat__;						\
> +	__pgdat__ = __nid__ < MAX_NUMNODES ? NODE_DATA(__nid__) : NULL;	\
> +	__pgdat__ &&							\
> +		__pfn__ >= __pgdat__->node_start_pfn &&			\
> +		__pfn__ - __pgdat__->node_start_pfn			\
> +				< __pgdat__->node_spanned_pages;	\
> +})

Boggle.

Does this evaulate to the same thing on non-discontigmem? (surely no)

Can we please arrange for it to?
