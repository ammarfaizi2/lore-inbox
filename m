Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSHGWYq>; Wed, 7 Aug 2002 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSHGWYo>; Wed, 7 Aug 2002 18:24:44 -0400
Received: from dsl-213-023-022-051.arcor-ip.net ([213.23.22.51]:59820 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314083AbSHGWYn>;
	Wed, 7 Aug 2002 18:24:43 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@arcor.de>
To: Jesse Barnes <jbarnes@sgi.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Date: Thu, 8 Aug 2002 00:30:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, jmacd@namesys.com, rml@tech9.net
References: <20020807210855.GA27182@sgi.com> <Pine.LNX.4.44L.0208071814250.23404-100000@imladris.surriel.com> <20020807221532.GA20469@sgi.com>
In-Reply-To: <20020807221532.GA20469@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17cZJi-00050N-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of whitespace glitches:

> +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> +#define MUST_HOLD(lock)                        BUG_ON(!spin_is_locked(lock))
> +#define MUST_NOT_HOLD(lock)            BUG_ON(spin_is_locked(lock))
> +#define MUST_HOLD_RW(lock)             BUG_ON(!rwlock_is_locked(lock))
> +#else
> +#define MUST_HOLD(lock)                        do { } while(0)
> +#define MUST_NOT_HOLD(lock)            do { } while(0)
> +#define MUST_HOLD_RW(lock)             do { } while(0)
> +#endif /* CONFIG_DEBUG_SPINLOCK && CONFIG_SMP */

Random gripe: don't all those do { } whiles look silly?  We need

   #define NADA do { } while (0)

or similar.

-- 
Daniel
