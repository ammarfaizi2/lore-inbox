Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVARCq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVARCq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 21:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVARCqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 21:46:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:53691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261218AbVARCqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 21:46:15 -0500
Date: Mon, 17 Jan 2005 18:46:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cputime.h seems to assume HZ==1000
In-Reply-To: <200501180157.j0I1v9YI013216@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0501171840560.8178@ppc970.osdl.org>
References: <200501180157.j0I1v9YI013216@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jan 2005, Roland McGrath wrote:
>
> Shouldn't msecs mean msecs, not secs/HZ?

Hmm, sure, but why go through "msecs" at all?

> --- linux-2.6/include/asm-generic/cputime.h
> +++ linux-2.6/include/asm-generic/cputime.h
> @@ -35,8 +35,8 @@ typedef u64 cputime64_t;
>  /*
>   * Convert cputime to seconds and back.
>   */
> -#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / HZ)
> -#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * HZ))
> +#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / 1000)
> +#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * 1000))

iow, why not

	#define cputime_to_secs(jif)	((jif) / HZ)
	#define secs_to_cputime(sec)	((sec) * HZ)

which avoids double rounding issues etc.

Not to mention that "secs_to_cputime()" lacks the proper parenthesis.

More signers-off-on-this-thing added.

		Linus
