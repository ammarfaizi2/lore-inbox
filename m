Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTHGPhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbTHGPhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:37:17 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:51077 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S270332AbTHGPhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:37:12 -0400
To: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator drivers/char/sx.c
References: <200308061830.05586.jeffpc@optonline.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 07 Aug 2003 02:32:28 +0200
In-Reply-To: <200308061830.05586.jeffpc@optonline.net>
Message-ID: <m3znimgvdv.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef 'Jeff' Sipek <jeffpc@optonline.net> writes:

> Just a simple fix to make the statements more readable. (instead of
> "i < TIMEOUT > 0" the statement is divided into two, joined by &&.)
> 
> Josef 'Jeff' Sipek
> 
> --- linux-2.5/drivers/char/sx.c.orig	2003-08-06 18:23:32.000000000 -0400
> +++ linux-2.5/drivers/char/sx.c	2003-08-06 18:20:03.000000000 -0400
> @@ -511,13 +511,13 @@
>  
>  	func_enter ();
>  
> -	for (i=0; i < TIMEOUT_1 > 0;i++) 
> +	for (i=0; (i < TIMEOUT_1) && (TIMEOUT_1 > 0);i++) 
>  		if ((read_sx_byte (board, offset) & mask) == correctval) {
>  			func_exit ();
>  			return 1;
>  		}
>  

While the first version seems to be a notation error (i < X > 0 is
equivalent to i < X) the changed version doesn't need X > 0 either
as TIMEOUT_1 (and TIMEOUT_2 respectively) is a positive #define.

So I think it should be just (i=0; i < TIMEOUT_1 ;i++) and so on.
-- 
Krzysztof Halasa
Network Administrator
