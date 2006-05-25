Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWEYBhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWEYBhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWEYBhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:37:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964841AbWEYBhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:37:02 -0400
Date: Wed, 24 May 2006 18:36:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] restore amikbd compatibility with 2.4
Message-Id: <20060524183634.44580870.akpm@osdl.org>
In-Reply-To: <20060525003421.958272000@linux-m68k.org>
References: <20060525002742.723577000@linux-m68k.org>
	<20060525003421.958272000@linux-m68k.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zippel@linux-m68k.org wrote:
>
> +	for (i = 0; i < MAX_NR_KEYMAPS; i++) {
>  +		static u_short temp_map[NR_KEYS] __initdata;
>  +		if (!key_maps[i])
>  +			continue;
>  +		memset(temp_map, 0, sizeof(temp_map));
>  +		for (j = 0; j < 0x78; j++) {
>  +			if (!amikbd_keycode[j])
>  +				continue;
>  +			temp_map[j] = key_maps[i][amikbd_keycode[j]];
>  +		}
>  +		for (j = 0; j < NR_KEYS; j++) {
>  +			if (!temp_map[j])
>  +				temp_map[j] = 0xf200;
>  +		}
>  +		memcpy(key_maps[i], temp_map, sizeof(temp_map));
>  +	}

I assume temp_map[] is static to avoid using too much stack.

But wouldn't it be simpler to make this code operate on key_maps[i] directly?


