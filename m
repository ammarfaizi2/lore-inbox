Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWHPSzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWHPSzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWHPSzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:55:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:24901 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWHPSzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:55:07 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=NTro22z2F9qimBK/Lclh+XgDbJqoODcgvdmFjjlcFuq89qRcsTt4x7FPqeBvIlof5
	S9nwo+s4RPvQBvh8b9RnA==
Subject: Re: [RFC][PATCH] UBC: user resource beancounters
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E33893.6020700@sw.ru>
References: <44E33893.6020700@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 16 Aug 2006 11:53:47 -0700
Message-Id: <1155754427.22595.88.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 19:24 +0400, Kirill Korotaev wrote:
> The following patch set presents base of
> User Resource Beancounters (UBC).
> UBC allows to account and control consumption
> of kernel resources used by group of processes.
> 
> The full UBC patch set allows to control:
> - kernel memory. All the kernel objects allocatable
>   on user demand should be accounted and limited
>   for DoS protection.
>   E.g. page tables, task structs, vmas etc.
> 

Good.

> - virtual memory pages. UBC allows to
>   limit a container to some amount of memory and
>   introduces 2-level OOM killer taking into account
>   container's consumption.
>   pages shared between containers are correctly
>   charged as fractions (tunable).
> 

I wouldn't be too worried about doing fractions.  Make it unfair and
charge it to either the container who first instantiated the file or the
container who faulted on that page first.

Though the part that seems important is to be able to define a directory
in fs and say all pages belonging to files underneath that directory are
going to be put in specific container.  Just like you are having
resource beans associated with sockets, have address_space or inode also
associated with resource beans. (And it should be possible to have a
container/resource bean without any active process but set of
address_space mappings with its own limits and current usage).

-rohit


