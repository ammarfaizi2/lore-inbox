Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWA2Tdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWA2Tdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWA2Tdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:33:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751125AbWA2Tde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:33:34 -0500
Date: Sun, 29 Jan 2006 11:33:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH] i386: Add a temporary to make put_user more type safe.
Message-Id: <20060129113312.73f31485.akpm@osdl.org>
In-Reply-To: <200601291620.28291.ioe-lkml@rameria.de>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
	<20060128235113.697e3a2c.akpm@osdl.org>
	<200601291620.28291.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> >  #define put_user(x,ptr)						\
>  >  ({	int __ret_pu;						\
>  >  	__chk_user_ptr(ptr);					\
>  > -	__typeof__(*(ptr)) __pu_val = x;			\
>  > +	__typeof__(x)*_p_;					\
>  > +	__typeof__(x)__pu_val;					\
>  > +								\
>  > +	_p_ = ptr;						\
>  > +	__pu_val = x;						\
>  >  	switch(sizeof(*(ptr))) {				\
> 
>  - 	switch(sizeof(*(ptr))) {				\
>  + 	switch(sizeof(*(_p_))) {				\
> 
>  > -	case 1: __put_user_1(__pu_val, ptr); break;		\
>  > -	case 2: __put_user_2(__pu_val, ptr); break;		\
>  > -	case 4: __put_user_4(__pu_val, ptr); break;		\
>  > -	case 8: __put_user_8(__pu_val, ptr); break;		\
>  > -	default:__put_user_X(__pu_val, ptr); break;		\
>  > +	case 1: __put_user_1(__pu_val, _p_); break;		\
>  > +	case 2: __put_user_2(__pu_val, _p_); break;		\
>  > +	case 4: __put_user_4(__pu_val, _p_); break;		\
>  > +	case 8: __put_user_8(__pu_val, _p_); break;		\
>  > +	default:__put_user_X(__pu_val, _p_); break;		\
>  >  	}							\
>  >  	__ret_pu;						\
>  >  })
> 
>  Does this now give less warnings?

No, it won't do.   All the warnings were legitimate anyway.
