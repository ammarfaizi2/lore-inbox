Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWHUPLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWHUPLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWHUPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:11:16 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:45773 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422672AbWHUPLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:11:15 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC: kernel memory accounting
	(core)
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <44E98D9F.1090101@sw.ru>
References: <44E33893.6020700@sw.ru> <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
		 <1155825493.9274.42.camel@localhost.localdomain> <44E588F0.40502@sw.ru>
	 <1155913113.9274.91.camel@localhost.localdomain> <44E98D9F.1090101@sw.ru>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 08:10:56 -0700
Message-Id: <1156173056.21208.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:40 +0400, Kirill Korotaev wrote:
> The one reason is that such an accounting allows to estimate the
> memory
> used/required by containers, while limitations by objects:
> - per object accounting/limitations do not provide any memory
> estimation

I know you're more clever than _that_. ;)

> - having a big number of reasonably high limits still allows the user
>   to consume big amount of memory. I.e. the sum of all the limits tend
>   to be high and potentially DoS exploitable :/
> - memory is easier to setup/control from user POV.
>   having hundreds of controls is good, but not much user friendly. 

I'm actually starting to think that some accounting memory usage *only*
in the slab, plus a few other structures for any stragglers not using
the slab would suffice.  Since the slab knows the size of the objects,
there is no ambiguity about how many are being used.  It should also be
a pretty generic way to control individual object types, if anyone else
should ever need it.

The high level pages-used-per-container metric is really nice for just
that, containers.  But, I wonder if other users would find it useful if
there were more precise ways of controlling individual object usage.

-- Dave

