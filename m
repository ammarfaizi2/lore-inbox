Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUKJU16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUKJU16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUKJUYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:24:46 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49795 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262118AbUKJUWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:22:12 -0500
Message-ID: <41926E3A.5020005@tmr.com>
Date: Wed, 10 Nov 2004 14:38:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zbigniew Szmek <zjedrzejewski-szmek@wp.pl>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make crypto modular
References: <200411082149.54723.zjedrzejewski-szmek@wp.pl>
In-Reply-To: <200411082149.54723.zjedrzejewski-szmek@wp.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zbigniew Szmek wrote:
> Cryptoapi can be modular, so why not?
> This patch does the following:
> 1. Change Kconfig option CRYPTO to tristate
> 2. Add __exit functions to crypto/api.c and crypto/proc.c
> 3. Change crypto/api.c:init_crypto() from void to int
> 4. Change crypto/Makefile to link hmac.o as part 
>    of the new crypto.ko module. 
>    
>    hmac.c could be compiled as a seperate module, if not for the fact,
>    that sizeof(struct digest_tfm) depends on CONFIG_CRYPTO_HMAC.
>    Linking them together ensures that there is no mismatch. If the user
>    compiles crypto.ko without HMAC, and then compiles another module
>    with HMAC, (for example ah4.ko), it will correctly fail with
>    "ah4: Unknown symbol crypto_hmac_init".
> 
> When CONFIG_CRYPTO=y the code generated should be identical,
> apart from point 3. above. When CONFIG_CRYPTO=m 
> size of crypto/crypto.ko is 15k.
> 
> The patch is against 2.6.10-rc1-mm1, applies cleanly to 2.6.10-rc1 and
> to 2.6.7 with two offsets.
> 
Good job! Reduces the memory cost of having the capability "just in 
case" needed in small memory machines.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

