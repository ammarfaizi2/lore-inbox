Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVF0IWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVF0IWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVF0IV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:21:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:57763 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261926AbVF0IVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:21:34 -0400
Date: Mon, 27 Jun 2005 10:19:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andi Kleen <ak@suse.de>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, Jeff Mahoney <jeffm@suse.de>,
       penberg@gmail.com, reiser@namesys.com, flx@namesys.com, zam@namesys.com,
       vs@thebsh.namesys.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627081923.GA9167@wohnheim.fh-wedel.de>
References: <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com> <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de> <1119717967.9392.2.camel@localhost> <20050627072449.GF19550@suse.de> <20050627072832.GA14251@wotan.suse.de> <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 June 2005 10:49:19 +0300, Pekka J Enberg wrote:
>  
>  #ifndef HAVE_ARCH_BUG_ON
> -#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
> +#define BUG_ON(condition) do { \
> +	if (unlikely((condition) != 0)) { \
> +		printk("kernel BUG '%s' at %s:%d!\n", #condition, __FILE__, __LINE__); \
> +		panic("BUG!"); \
> +	} \
> +} while(0)
>  #endif

o How about those architectures, where BUG() and panic() are not the
  same thing?
o Embedded people might prefer not to have the additional string
  constants in the kernel.  Some config option would ease their wrath.
  And no, not all embedded people #define BUG() to nothing.

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
