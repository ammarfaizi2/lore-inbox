Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270309AbRH1HKt>; Tue, 28 Aug 2001 03:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270311AbRH1HKj>; Tue, 28 Aug 2001 03:10:39 -0400
Received: from ns.suse.de ([213.95.15.193]:4369 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270309AbRH1HKd>;
	Tue, 28 Aug 2001 03:10:33 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.21.0108271717110.7131-100000@freak.distro.conectiva.suse.lists.linux.kernel> <Pine.LNX.4.21.0108272254470.7514-100000@freak.distro.conectiva.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2001 09:10:43 +0200
In-Reply-To: Marcelo Tosatti's message of "28 Aug 2001 05:31:51 +0200"
Message-ID: <oupofp0k6bw.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> --- linux.orig/fs/buffer.c	Mon Aug 27 20:46:36 2001
> +++ linux/fs/buffer.c	Mon Aug 27 21:43:35 2001
> @@ -2448,6 +2448,10 @@
>  	write_unlock(&hash_table_lock);
>  	spin_unlock(&lru_list_lock);
>  	if (gfp_mask & __GFP_IO) {
> +#ifdef CONFIG_HIGHMEM
> +		if (!(gfp_mask & __GFP_HIGHIO) & PageHighMem(page))
                                              ^^
Should clearly be &&
Could be a problem if PageHighMem returns something other than 1 for true.


-Andi
