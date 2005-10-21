Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVJUB5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVJUB5E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 21:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVJUB5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 21:57:04 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:3415 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964839AbVJUB5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 21:57:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYbSV+X31GEH5dQqBoBOrd4aU4WIf+6ew8u7A8ltIL77q7D/mEEixlKKxOgcw2c4+gLWYKSPYcRzPWjI99OOf5MIeVbGY3eVBdYdhGZdIXzZzMEbT4QI7SkcXL4lbljcdd86tuWfiWtHxjDsds/rg0BTgCQXHgY/PMWQB5URf04=
Message-ID: <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com>
Date: Fri, 21 Oct 2005 10:57:02 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Cc: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Christoph Lameter <clameter@sgi.com> wrote:
> Page migration is also useful for other purposes:
>
> 1. Memory hotplug. Migrating processes off a memory node that is going
>    to be disconnected.
>
> 2. Remapping of bad pages. These could be detected through soft ECC errors
>    and other mechanisms.

3. Migrating between zones.

The current per-zone LRU design might have some drawbacks. I would
prefer a per-node LRU to avoid that certain zones needs to shrink more
often than others. But maybe that is not the case, please let me know
if I'm wrong.

If you think about it, say that a certain user space page happens to
be allocated from the DMA zone, and for some reason this DMA zone is
very popular because you have crappy hardware, then it might be more
probable that this page is paged out before some other much older/less
used page in another (larger) zone. And I guess the same applies to
small HIGHMEM zones.

This could very well be related to the "1 GB Memory is bad for you"
problem described briefly here: http://kerneltrap.org/node/2450

Maybe it is possible to have a per-node LRU and always page out the
least recently used page in the entire node, and then migrate pages to
solve specific "within N bits of address space" requirements.

But I'm probably underestimating the cost of page migration...

/ magnus
