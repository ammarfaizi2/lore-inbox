Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbVI3WXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbVI3WXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVI3WXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:23:44 -0400
Received: from hera.kernel.org ([140.211.167.34]:54503 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030475AbVI3WXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:23:43 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: reiser4 compilation fix [ was: 2.6.14-rc2-mm2]
Date: Fri, 30 Sep 2005 15:23:56 -0700
Organization: OSDL
Message-ID: <20050930152356.35597449@dxpl.pdx.osdl.net>
References: <20050929143732.59d22569.akpm@osdl.org>
	<200510010202.32667.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1128119016 17453 10.8.0.74 (30 Sep 2005 22:23:36 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Fri, 30 Sep 2005 22:23:36 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Andrew, please add this reiser4 compilation fix :
> ---------------------------------------------------
> --- a/fs/reiser4/spin_macros.h
> +++ b/fs/reiser4/spin_macros.h
> @@ -82,8 +82,6 @@ typedef struct reiser4_rw_data {
>  static inline void spin_ ## NAME ## _init(TYPE *x)				\
>  {										\
>  	__ODCA("nikita-2987", x != NULL);					\
> -	cassert(sizeof(x->FIELD) != 0);						\
> -	memset(& x->FIELD, 0, sizeof x->FIELD);					\
>  	spin_lock_init(& x->FIELD.lock);					\
>  }										\
>  										\
> @@ -236,7 +234,6 @@ typedef struct { int foo; } NAME ## _spi
>  static inline void rw_ ## NAME ## _init(TYPE *x)				\
>  {										\
>  	__ODCA("nikita-2988", x != NULL);					\
> -	memset(& x->FIELD, 0, sizeof x->FIELD);					\
>  	rwlock_init(& x->FIELD.lock);						\
>  }										\
>  										\

These are just the kind of bogus macro's that block reiser4 from
getting merged.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
