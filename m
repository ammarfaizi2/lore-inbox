Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275401AbTHIUgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275403AbTHIUgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:36:43 -0400
Received: from rth.ninka.net ([216.101.162.244]:29320 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S275401AbTHIUgl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:36:41 -0400
Date: Sat, 9 Aug 2003 13:36:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Mika =?ISO-8859-1?B?UGVudHRpbOQ=?= <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: cryptoapi incorrect struct page usage
Message-Id: <20030809133637.137e8128.davem@redhat.com>
In-Reply-To: <3F355AB0.6@kolumbus.fi>
References: <3F355AB0.6@kolumbus.fi>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Aug 2003 23:33:52 +0300
Mika Penttilä <mika.penttila@kolumbus.fi> wrote:

>         sg[elt].page = virt_to_page(skb->data + offset);
>         sg[elt].offset = (unsigned long)(skb->data + offset) % PAGE_SIZE;
>         sg[elt].length = copy;
> 
> so unpinned pages are passed to cryptoapi. Nothing prevents these pages 
> from being swapped out. Something like get_user_pages() is needed to pin 
> these pages for the duration of crypto operations. Comments?

The page at skb->data was allocated by the skbuff allocation
layer, it has therefore a lifetime the size of the SKB itself.

The crypto API call is finished before we can possibly free up
the SKB, so nothing bad can happen.
