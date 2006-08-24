Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWHXPB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWHXPB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHXPB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:01:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751572AbWHXPB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:01:57 -0400
Date: Thu, 24 Aug 2006 08:00:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Message-Id: <20060824080030.05232740.akpm@osdl.org>
In-Reply-To: <44ED9633.7090504@sw.ru>
References: <44EC31FB.2050002@sw.ru>
	<44EC35EB.1030000@sw.ru>
	<20060823094202.ff3a5573.akpm@osdl.org>
	<44ED9633.7090504@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2006 16:06:11 +0400
Kirill Korotaev <dev@sw.ru> wrote:

> >>+#define bc_charge_locked(bc, r, v, s)			(0)
> >>> +#define bc_charge(bc, r, v)				(0)
> >
> >akpm:/home/akpm> cat t.c
> >void foo(void)
> >{
> >	(0);
> >}
> >akpm:/home/akpm> gcc -c -Wall t.c
> >t.c: In function 'foo':
> >t.c:4: warning: statement with no effect
> 
> these functions return value should always be checked (!).

We have __must_check for that.

> i.e. it is never called like:
>   ub_charge(bc, r, v);

Also...

	if (bc_charge(tpyo, undefined_variable, syntax_error))

will happily compile if !CONFIG_BEANCOUNTER.

Turning these stubs into static inline __must_check functions fixes all this.
