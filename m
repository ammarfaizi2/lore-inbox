Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293432AbSCAE4e>; Thu, 28 Feb 2002 23:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310222AbSCAEy1>; Thu, 28 Feb 2002 23:54:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22567 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S293432AbSCAEti>; Thu, 28 Feb 2002 23:49:38 -0500
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <E16eT9h-0000kE-00@wagner.rustcorp.com.au>
	<20020225100025.A1163@elinux01.watson.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Feb 2002 21:44:40 -0700
In-Reply-To: <20020225100025.A1163@elinux01.watson.ibm.com>
Message-ID: <m1y9hc3nif.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> Rusty, since I supplied one of those packages available under
> lse.sourceforge.net
> 
> let me make some comments.
> 
> (a) why do you need to pin. I simply use the user level address (vaddr)  
>     and hash with the <mm,vaddr> to obtain the internal object.
>     This also gives me full protection through the general vmm mechanisms.

Do: 
if (page->mapping) 
    hash(page->mapping, page->offset, vaddr & ~PAGE_MASK)
else
    hash(mm, vaddr)
This handles the semaphores in shared memory case.  So the semaphores
will work across processes as well.

> (c) creation can be done on demand, that's what I do. If you never have 
>     to synchronize through the kernel than you don't create the objects. 
>     There should be an option to force explicite creation if desired.

Which makes the uncontended (common) case fast.

> (d) The kernel should simply provide waiting and wakeup functionality and 
>     the bean counting should be done in user space. There is no need to 
>     pin or crossmap.

Agreed.

Eric
