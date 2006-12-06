Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936957AbWLFRyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936957AbWLFRyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936958AbWLFRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:54:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49801 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936957AbWLFRyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:54:07 -0500
Date: Wed, 6 Dec 2006 09:53:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
In-Reply-To: <21690.1165426993@redhat.com>
Message-ID: <Pine.LNX.4.64.0612060951150.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> 
 <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org>  <21690.1165426993@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, David Howells wrote:
> 
> +	if (get_wq_data(work) == cwq
> +	    && test_bit(WORK_STRUCT_PENDING, &work->management)
> 
> I wonder if those can be combined, perhaps:

Gcc should do it for us, afaik. I didn't check, but gcc is generally 
pretty good at combining logical operations like this, because it's very 
common.

> Otherwise for i386 the compiler can't combine them because test_bit() is done
> with inline asm.

Nope. Look again.

test_bit() with a constant number is done very much in C, and very much on 
purpose. _Exactly_ to allow the compiler to combine these kinds of things.

> And:
> 
> +		if (!test_bit(WORK_STRUCT_PENDING, &work->management))
> 
> Should possibly be:
> 
> +		if (!work_pending(work))

Yeah, that's a worthy cleanup.

		Linus
