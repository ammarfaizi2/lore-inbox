Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUGPQoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUGPQoQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 12:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUGPQoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 12:44:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:50063 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S266582AbUGPQoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 12:44:14 -0400
Date: Fri, 16 Jul 2004 18:44:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040716164435.GA8078@ucw.cz>
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87llhjlxjk.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:
> KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
> key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
> 
> 	key_map[0] = U(K_ALLOCATED);
> 	for (j = 1; j < NR_KEYS; j++)
> 		key_map[j] = U(K_HOLE);

The patch below might cause problems, though, because some apps may (in
old versions are) using a char variable to index up to NR_KEYS, which
leads to an endless loop.

> 
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> ---
> 
>  include/linux/keyboard.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN include/linux/keyboard.h~nr_keys-off-by-one include/linux/keyboard.h
> --- linux-2.6.8-rc1/include/linux/keyboard.h~nr_keys-off-by-one	2004-07-16 06:20:10.000000000 +0900
> +++ linux-2.6.8-rc1-hirofumi/include/linux/keyboard.h	2004-07-16 06:20:10.000000000 +0900
> @@ -16,7 +16,7 @@
>  
>  #define NR_SHIFT	9
>  
> -#define NR_KEYS		255
> +#define NR_KEYS		256
>  #define MAX_NR_KEYMAPS	256
>  /* This means 128Kb if all keymaps are allocated. Only the superuser
>  	may increase the number of keymaps beyond MAX_NR_OF_USER_KEYMAPS. */
> _
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
