Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319578AbSIHIZz>; Sun, 8 Sep 2002 04:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319579AbSIHIZz>; Sun, 8 Sep 2002 04:25:55 -0400
Received: from holomorphy.com ([66.224.33.161]:18873 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319578AbSIHIZy>;
	Sun, 8 Sep 2002 04:25:54 -0400
Date: Sun, 8 Sep 2002 01:28:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <20020908082821.GK888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, akpm@digeo.com,
	ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
References: <3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com> <3D7B0177.6A35FE9B@digeo.com> <20020908.003700.07120871.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020908.003700.07120871.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
>    So it's a bit of rmap in there.  I'd have to compare with a 2.4
>    profile and fiddle a few kernel parameters.  But I'm not sure
>    that munmap of extremely sparsely populated pagtetables is very
>    interesting?

On Sun, Sep 08, 2002 at 12:37:00AM -0700, David S. Miller wrote:
> Another issue is that x86 doesn't use a pagetable cache.  I think it
> got killed from x86 when the pagetables in highmem went in.
> This is all from memory.

They seemed to have some other issues related to extreme memory
pressure (routine for me). But if this were truly the issue, the
allocation and deallocation overhead for pagetables should show up as
additional pressure against zone->lock. I can't tell at the moment
because zone->lock is hammered quite hard to begin with and no one's
gone out and done a pagetable cacheing patch for the stuff since. It
should be simple to chain with links in struct page instead of links
embedded in the pagetables & smp_call_function() to reclaim. But this
raises questions of generality.

Cheers,
Bill
