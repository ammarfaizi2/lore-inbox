Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbTDOF3f (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbTDOF3f (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:29:35 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:21228 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S264293AbTDOF3e (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:29:34 -0400
Date: Tue, 15 Apr 2003 07:52:29 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030415055229.GJ14552@wind.cocodriloo.com>
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030415020057.GC706@holomorphy.com> <20030415041759.GA12487@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415041759.GA12487@holomorphy.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 09:17:59PM -0700, William Lee Irwin III wrote:
> On Mon, Apr 14, 2003 at 07:00:57PM -0700, William Lee Irwin III wrote:
> > Hence, this "FIXME: do not do for zone highmem". Presumably this is a
> 
> Another FIXME patch:
> 
> 
> It's a bit of an open question as to how much of a difference this one
> makes now, but it says "FIXME". fault_in_pages_writeable() and 
> fault_in_pages_readable() have a limited "range" with respect to the
> size of the region they can prefault; as they are now, they are only
> meant to handle spanning a page boundary. This converts them to iterate
> over the virtual address range specified and so touch each virtual page
> within it once as specified. As per the comment within the "FIXME",
> this is only an issue if PAGE_SIZE < PAGE_CACHE_SIZE.
> 
> [patch snip]

Page clustering? I did a simple patch yesterday called "cow-ahead", which
may be related: on a write to a COW page, it breaks the COW from several pages
at the same time. The implementation survived a complete debian 2.2 boot
and a fork bomb. Please have a look. The idea came from a discussion with
Martin J. Bligh... we liked the name too much not to implement it.

Greets, Antonio.
