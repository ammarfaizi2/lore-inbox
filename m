Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSLQUJv>; Tue, 17 Dec 2002 15:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265767AbSLQUJv>; Tue, 17 Dec 2002 15:09:51 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18613
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265636AbSLQUJt>; Tue, 17 Dec 2002 15:09:49 -0500
Message-ID: <3DFF8668.9080209@redhat.com>
Date: Tue, 17 Dec 2002 12:17:44 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171159440.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171159440.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> ===== arch/i386/kernel/sysenter.c 1.1 vs edited =====
> --- 1.1/arch/i386/kernel/sysenter.c	Mon Dec 16 21:39:04 2002
> +++ edited/arch/i386/kernel/sysenter.c	Tue Dec 17 11:39:39 2002
> @@ -48,14 +48,14 @@
>  		0xc3			/* ret */
>  	};
>  	static const char sysent[] = {
> -		0x55,			/* push %ebp */
>  		0x51,			/* push %ecx */
>  		0x52,			/* push %edx */
> +		0x55,			/* push %ebp */
>  		0x89, 0xe5,		/* movl %esp,%ebp */
>  		0x0f, 0x34,		/* sysenter */
> +		0x5d,			/* pop %ebp */
>  		0x5a,			/* pop %edx */
>  		0x59,			/* pop %ecx */
> -		0x5d,			/* pop %ebp */
>  		0xc3			/* ret */

Instead of duplicating the push/pop %ebp just use the first one by using

  movl 12(%ebo), %ebp

in the kernel code or remove the first.  The later is better, smaller code.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

