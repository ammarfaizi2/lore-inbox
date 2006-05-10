Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWEJLmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWEJLmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWEJLmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:42:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:5994 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964931AbWEJLmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:42:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HXPOpUuVEMstTF1cpUKA1AkVWSOj2yuU82t5UdNmBeIsRf1DyLw1DXZ3lgnZ95RP8Og1o8Pgtl1NEVsj+NBguUk1zfX6MoYUI009QiJWeZSpgyjZq+rMFMKSvtljbhq66hqhg3mzWJUBh2DWMxGN3LuZXyspoV6HJAPRCiVKQvQ=
Message-ID: <84144f020605100442g617e9ddfk45ce444483ea86b8@mail.gmail.com>
Date: Wed, 10 May 2006 14:42:20 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
Cc: "linux list" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200605102132.41217.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605102132.41217.kernel@kolivas.org>
X-Google-Sender-Auth: 86b31a03400b7790
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Con Kolivas <kernel@kolivas.org> wrote:
> +/*
> + * A swap entry has to fit into a "unsigned long", as
> + * the entry is hidden in the "index" field of the
> + * swapper address space.
> + */
> +#ifdef CONFIG_SWAP
>  typedef struct {
>         unsigned long val;
>  } swp_entry_t;
> +#else
> +typedef struct {
> +       unsigned long val;
> +} swp_entry_t __attribute__((__unused__));
> +#endif

Or we could make swap_free() an empty static inline function for the
non-CONFIG_SWAP case.

                                                     Pekka
