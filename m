Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVCBVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVCBVWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVCBVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:22:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:23466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262475AbVCBVV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:21:58 -0500
Date: Wed, 2 Mar 2005 13:18:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: bunk@stusta.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc4-mm1 patch] fix buggy IEEE80211_CRYPT_* selects
Message-Id: <20050302131817.2e61805f.akpm@osdl.org>
In-Reply-To: <42262B08.2040401@pobox.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<20050226113123.GJ3311@stusta.de>
	<42256078.1040002@pobox.com>
	<20050302140833.GD4608@stusta.de>
	<42261004.4000501@pobox.com>
	<20050302123829.51dbc44b.akpm@osdl.org>
	<42262B08.2040401@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > Thing is, CRYPTO_AES on only selectable on x86.
> 
>  You're thinking about CRYPTO_AES_586.  But looking at crypto/Kconfig, 
>  the dependencies are a bit weird:
> 
>  config CRYPTO_AES
>           tristate "AES cipher algorithms"
>           depends on CRYPTO && !(X86 && !X86_64)
>  config CRYPTO_AES_586
>           tristate "AES cipher algorithms (i586)"
>           depends on CRYPTO && (X86 && !X86_64)

That's pretty broken, isn't it?

Would be better to just do:

config CRYPTO_AES
	select CRYPTO_AES_586 if (X86 && !X86_64)
	select CRYPTO_AES_OTHER if !(X86 && !X86_64)

and hide CRYPTO_AES_586 and CRYPTO_AES_OTHER from the outside world.
