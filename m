Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVJ3Kiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVJ3Kiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 05:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVJ3Kiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 05:38:46 -0500
Received: from ns2.suse.de ([195.135.220.15]:5318 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751212AbVJ3Kip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 05:38:45 -0500
From: Andreas Schwab <schwab@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, "Sergey S. Kostyliov" <rathamahata@php4.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] befs: use strlcpy()
References: <20051030011817.GA32602@mipter.zuzino.mipt.ru>
X-Yow: I think I'll make SCRAMBLED EGGS!!  They're each in LITTLE SHELLS..
Date: Sun, 30 Oct 2005 11:38:36 +0100
In-Reply-To: <20051030011817.GA32602@mipter.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Sun, 30 Oct 2005 04:18:17 +0300")
Message-ID: <jebr175lxv.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> --- a/fs/befs/btree.c
> +++ b/fs/befs/btree.c
> @@ -503,10 +503,9 @@ befs_btree_read(struct super_block *sb, 
>  		goto error_alloc;
>  	};
>  
> -	strncpy(keybuf, keystart, keylen);
> +	strlcpy(keybuf, keystart, keylen);
>  	*value = fs64_to_cpu(sb, valarray[cur_key]);
>  	*keysize = keylen;
> -	keybuf[keylen] = '\0';

You are now cutting off the last character of the string.  keylen is the
exact size of the string to be copied, _not_ the size of the buffer (which
is bufsize and guaranteed to be big enough at this point).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
