Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVHUVYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVHUVYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVHUVYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:24:24 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:24523 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751122AbVHUVYX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:24:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AfplmVRlh8u9MU+YwMOqvxKEWbMIXRrR/GaAA5O1n/3CKKXok8qwfW8Qcqsfu+FupajVG5rYuC8LsfPPUD8Q3btno6OCLRg0/Ym0yPLaoxjh+WU01cPD9DTY4gkerNqy5oW02/PmYrD9ZqzccPRJsTKu2WXTehbSM4RlEcQkGoc=
Message-ID: <84144f0205082112477979b053@mail.gmail.com>
Date: Sun, 21 Aug 2005 22:47:13 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050820193237.GG3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050820193237.GG3615@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/05, Adrian Bunk <bunk@stusta.de> wrote:
> This change could (at least in theory) allow a compiler better
> optimization (especially in the n=1 case).
> 
> The practical effect seems to be nearly zero:
>     text           data     bss      dec            hex filename
> 25617207        5850138 1827016 33294361        1fc0819 vmlinux-old
> 25617191        5850138 1827016 33294345        1fc0809 vmlinux-patched
> 
> Is there any reason against this patch?

Looks ok to me.

On 8/20/05, Adrian Bunk <bunk@stusta.de> wrote:
>  static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
>  {
> -       if (n != 0 && size > INT_MAX / n)
> +       if (n != 0 && size > ULONG_MAX / n)

You'll probably get even better code if you change the above to:

    if (size != 0 && n > ULONG_MAX / size)

Reason being that size is virtually always a constant so the compiler
can evaluate the division at compile-time.

                                  Pekka
