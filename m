Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275710AbRIZXzg>; Wed, 26 Sep 2001 19:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275709AbRIZXzQ>; Wed, 26 Sep 2001 19:55:16 -0400
Received: from dict.and.org ([63.113.167.10]:22167 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S275707AbRIZXzH>;
	Wed, 26 Sep 2001 19:55:07 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
	<jeelp4rbtf.fsf@sykes.suse.de>
	<20010918143827.A16003@gruyere.muc.suse.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 26 Sep 2001 19:54:59 -0400
In-Reply-To: <20010918143827.A16003@gruyere.muc.suse.de>
Message-ID: <nn3d59qzho.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> Good point. I somehow assumed that __builtin_expect would just signify
> a boolean, but if I read gcc source correctly this was wrong.

 Yeh, it's a long so you'll get no cast warnings too.

> Here is an updated patch.

[snip ... ]

> --- include/linux/kernel.h-LIKELY	Tue Sep 18 11:12:20 2001
> +++ include/linux/kernel.h	Tue Sep 18 14:35:17 2001
> @@ -171,4 +171,14 @@
>  	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
>  };
>  
> +
> +/* This loses on a few early 2.96 snapshots, but hopefully nobody uses them anymore. */ 
> +#if __GNUC__ > 2 || (__GNUC__ == 2 && _GNUC_MINOR__ == 96)
> +#define likely(x)  __builtin_expect(!!(x), 1) 
> +#define unlikely(x)  __builtin_expect((x), 0) 

 unlikely() also needs to be...

#define unlikely(x)  __builtin_expect(!(x), 1) 

...or...

#define unlikely(x)  __builtin_expect(!!(x), 0) 

> +#else
> +#define likely(x) (x)
> +#define unlikely(x) (x)
> +#endif
> +
>  #endif

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
