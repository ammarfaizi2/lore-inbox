Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWFUSOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWFUSOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFUSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:14:15 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50054 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751144AbWFUSOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:14:15 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=dxSJaKHCg5zDZbVxgl3UAvA4jJj+FGcQlhESYslGuvsgQcGYrt7fvNPUPIc/7McxJ
	sSlc8r4/gtq8v5FOdhuGw==
Message-ID: <44998C4F.8090502@google.com>
Date: Wed, 21 Jun 2006 11:13:35 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Nick Piggin <npiggin@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Hans Reiser <reiser@namesys.com>, "E. Gryaznova" <grev@namesys.com>
Subject: Re: [PATCH] mm/tracking dirty pages: update get_dirty_limits for
 mmap tracking
References: <5c49b0ed0606211001s452c080cu3f55103a130b78f1@mail.gmail.com>
In-Reply-To: <5c49b0ed0606211001s452c080cu3f55103a130b78f1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -int vm_dirty_ratio = 40;
> +int vm_dirty_ratio = 80;

I don't think you can do that. Because ...

>     unsigned long available_memory = total_pages;
...
> +    dirty = (vm_dirty_ratio * available_memory) / 100;

... there are other things in memory besides pagecache. Limiting
dirty pages to 80% of pagecache might be fine, but not 80%
of total memory.

dirty = (vm_dirty_ratio * (nr_active + nr_inactive)) / 100

might be more sensible. Frankly the whole thing is a crock
anyway, because we should be counting easily freeable clean
pages, not dirty pages, but still.

M.
