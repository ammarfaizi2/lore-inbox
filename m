Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVBAQwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVBAQwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVBAQwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:52:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36320 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262066AbVBAQv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:51:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Pzzx5sppRE0TGl0BzR2mf9QxwZu7awFbtU0AeIMCpzly3XimU5xOoC07wt5lTUcjPPM1F5bxaZqNK2ie35IE5CB84es+FaUp+vrTjdMnG3+U8LmmmH2yXWAbg1p3dOTgDljW+6LP2U/mURzF2cHtyKISxygbgp3GnYvfBBcdgaY=
Message-ID: <84144f0205020108441679cbef@mail.gmail.com>
Date: Tue, 1 Feb 2005 18:44:01 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "pmarques@grupopie.com" <pmarques@grupopie.com>
Subject: Re: [PATCH 2.6] 1/7 create kstrdup library function
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1107228501.41fef755e66e8@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1107228501.41fef755e66e8@webmail.grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  1 Feb 2005 03:28:21 +0000, pmarques@grupopie.com
<pmarques@grupopie.com> wrote:
> 
> This patch creates the kstrdup library function so that it doesn't have to be
> reimplemented (or even EXPORT'ed) by every user that needs it.
> 
> Signed-off-by: Paulo Marques <pmarques@grupopie.com>
> 
> diff -buprN -X dontdiff vanilla-2.6.11-rc2-bk9/lib/string.c linux-2.6.11-rc2-bk9/lib/string.c
> --- vanilla-2.6.11-rc2-bk9/lib/string.c 2005-01-31 20:05:37.000000000 +0000
> +++ linux-2.6.11-rc2-bk9/lib/string.c   2005-01-31 20:00:31.000000000 +0000
> @@ -599,3 +599,23 @@ void *memchr(const void *s, int c, size_
>  }
>  EXPORT_SYMBOL(memchr);
>  #endif
> +
> +/*
> + * kstrdup - allocate space for and copy an existing string
> + *
> + * @s: the string to duplicate
> + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> + */
> +char *kstrdup(const char *s, int gfp)
> +{
> +       int len;
> +       char *buf;
> +
> +       if (!s) return NULL;
> +
> +       len = strlen(s) + 1;
> +       buf = kmalloc(len, gfp);
> +       if (buf)
> +               memcpy(buf, s, len);
> +       return buf;
> +}
> +
> +EXPORT_SYMBOL(kstrdup);

kstrdup() is a special-case _memory allocator_ (not so much a string
operation) so I think it should go into mm/slab.c where we currently
have kcalloc().

P.S. Please inline patches to your email as per
Documentation/SubmittingPatches. I, for one, have trouble with
attachments.

                                   Pekka
