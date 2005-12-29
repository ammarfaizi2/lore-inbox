Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVL2LgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVL2LgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVL2LgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:36:19 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:7287 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932591AbVL2LgT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:36:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oy+rng50TV1tRgf6NjtGhTtoHZrCcCnxHZEPqIj9NPkglFtC1DlAzjv5aYKmREIl2ktp+PSZm4j2lS9vZaxwVgZ6TkXLqzHnoFz09tLkXjvd4hBcTkinVG0C3uScXOAKxgIJVIC9ByWPQoeKboZjfhftP9dT5KDPs/OXVmpSSOQ=
Message-ID: <84144f020512290336p1d46c0a9t1c63e9c8cecc7061@mail.gmail.com>
Date: Thu, 29 Dec 2005 13:36:17 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: kus Kusche Klaus <kus@keba.com>
Subject: Re: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       clameter@sgi.com, mpm@selenic.com
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323302@MAILIT.keba.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AAD6DA242BC63C488511C611BD51F367323302@MAILIT.keba.co.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/29/05, kus Kusche Klaus <kus@keba.com> wrote:
> My sa1100-based system panics while booting with 2.6.15-rc7-rt1 when the
> SLAB allocator is configured. Everything is fine with the SLOB
> allocator.
>
> Please cc me, I'm currently not subscribed.
>
> Memory: 62856KB available (1552K code, 381K data, 80K init)
> Unhandled fault: alignment exception (0xc0207003) at 0x0000015b
> Internal error: : c0207003 [#1]
> Modules linked in:
> CPU: 0
> PC is at get_page_from_freelist+0x1c/0x3d8
> LR is at __alloc_pages+0x5c/0x2ac

Unfortunately, I am clueless of arm (and have no idea what alignment
exception is) but the problem is probably related to mm/slab.c using
alloc_pages_node() whereas mm/slob.c uses get_free_page(). Do you have
CONFIG_BUG enabled? If not, please turn it on to see if gfp_zone()
catches an invalid GFP flag coming from the slab.

                             Pekka
