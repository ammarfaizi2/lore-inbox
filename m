Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWJ2PWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWJ2PWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbWJ2PWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:22:44 -0500
Received: from smtp-out.google.com ([216.239.45.12]:44707 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965047AbWJ2PWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:22:44 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=nbEF7B3aFMFbQkXsn4nY72qE0RfKnmuLkAEoTk7YM5Ctiwhiy9Miuk9mvbMyHSSWw
	K1syQEs2SVxFqM78pIoug==
Message-ID: <4544C709.6070305@google.com>
Date: Sun, 29 Oct 2006 07:21:45 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Giridhar Pemmasani <pgiri@yahoo.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Slab panic on 2.6.19-rc3-git5 (-git4 was OK)
References: <20061029124655.7014.qmail@web32408.mail.mud.yahoo.com>
In-Reply-To: <20061029124655.7014.qmail@web32408.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I only skimmed through this briefly but it looks like due to
>> 52fd24ca1db3a741f144bbc229beefe044202cac __get_vm_area_node is passing
>> GFP_HIGHMEM to kmem_cache_alloc_node which is a no-no.
> 
> I haven't been able to reproduce this, although I understand why it happens:
> vmalloc allocates memory with
> 
> GFP_KERNEL | __GFP_HIGHMEM
> 
> and with git5, the same flags are passed down to cache_alloc_refill, causing
> the BUG. The following patch against 2.6.19-rc3-git5 (also attached as
> attachment, as this mailer may mess up inline copying) should fix it.

Thanks for the patch ... but more worrying is how this got broken.
Wasn't the point of having the -mm tree that patches like this went
through it for testing, and we avoid breaking mainline? especially
this late in the -rc cycle.

M.
