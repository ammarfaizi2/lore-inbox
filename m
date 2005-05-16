Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVEPVR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVEPVR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVEPVMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:12:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:14533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261884AbVEPVLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:11:43 -0400
Date: Mon, 16 May 2005 14:08:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: chrisw@osdl.org, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [2.6 patch] security/: possible cleanups
Message-ID: <20050516210815.GW27549@shell0.pdx.osdl.net>
References: <20050516184501.GD5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516184501.GD5112@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global function:
>   - keys/key.c: key_duplicate
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Ack for seclvl change.
Acked-by: Chris Wright <chrisw@osdl.org>

I see no issue with the keys changes, except I'd rather see key_duplicate
removed entirely if it's not getting used.  David, is there a plan to
put it to use, or can Adrian remove it?

thanks,
-chris

> --- linux-2.6.12-rc4-mm1-full/security/keys/internal.h.old	2005-05-15 17:11:19.000000000 +0200
> +++ linux-2.6.12-rc4-mm1-full/security/keys/internal.h	2005-05-15 17:11:23.000000000 +0200
> @@ -25,7 +25,6 @@
>  #define kdebug(FMT, a...)	do {} while(0)
>  #endif
>  
> -extern struct key_type key_type_dead;
>  extern struct key_type key_type_user;
>  
>  /*****************************************************************************/
> --- linux-2.6.12-rc4-mm1-full/security/keys/key.c.old	2005-05-15 17:09:56.000000000 +0200
> +++ linux-2.6.12-rc4-mm1-full/security/keys/key.c	2005-05-15 17:11:11.000000000 +0200
> @@ -35,7 +35,7 @@
>  DECLARE_RWSEM(key_construction_sem);
>  
>  /* any key who's type gets unegistered will be re-typed to this */
> -struct key_type key_type_dead = {
> +static struct key_type key_type_dead = {
>  	.name		= "dead",
>  };
>  
> @@ -860,6 +860,7 @@
>   * duplicate a key, potentially with a revised description
>   * - must be supported by the keytype (keyrings for instance can be duplicated)
>   */
> +#if 0
>  struct key *key_duplicate(struct key *source, const char *desc)
>  {
>  	struct key *key;
> @@ -904,6 +905,7 @@
>  	goto out;
>  
>  } /* end key_duplicate() */
> +#endif  /*  0  */
>  
>  /*****************************************************************************/
>  /*
> --- linux-2.6.12-rc4-mm1-full/security/keys/keyring.c.old	2005-05-15 17:12:43.000000000 +0200
> +++ linux-2.6.12-rc4-mm1-full/security/keys/keyring.c	2005-05-15 17:12:53.000000000 +0200
> @@ -69,7 +69,7 @@
>   * semaphore to serialise link/link calls to prevent two link calls in parallel
>   * introducing a cycle
>   */
> -DECLARE_RWSEM(keyring_serialise_link_sem);
> +static DECLARE_RWSEM(keyring_serialise_link_sem);
>  
>  /*****************************************************************************/
>  /*
