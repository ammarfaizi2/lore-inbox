Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbTBJBiV>; Sun, 9 Feb 2003 20:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBJBhO>; Sun, 9 Feb 2003 20:37:14 -0500
Received: from dp.samba.org ([66.70.73.150]:57517 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267528AbTBJBg5>;
	Sun, 9 Feb 2003 20:36:57 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Frank Davis <fdavis@si.rr.com>
Cc: R.E.Wolff@BitWizard.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 : drivers/char/sx.c 
In-reply-to: Your message of "Fri, 07 Feb 2003 12:21:46 CDT."
             <Pine.LNX.4.44.0302071219540.6917-100000@master> 
Date: Mon, 10 Feb 2003 11:30:29 +1100
Message-Id: <20030210014642.673722C2B7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302071219540.6917-100000@master> you write:
> Hello all,
>    The following patch addresses buzilla bug # 322, and removes a double 
> logical issue. Please review for inclusion.
> 
> Regards,
> Frank

Roger?  Is this what was meant here?

Thanks,
Rusty.

> --- linux/drivers/char/sx.c.old	2003-01-16 21:22:03.000000000 -0500
> +++ linux/drivers/char/sx.c	2003-02-07 02:30:33.000000000 -0500
> @@ -522,13 +522,13 @@
>  
>  	func_enter ();
>  
> -	for (i=0; i < TIMEOUT_1 > 0;i++) 
> +	for (i=0; ((TIMEOUT_1 > 0) && (i < TIMEOUT_1));i++) 
>  		if ((read_sx_byte (board, offset) & mask) == correctval) {
>  			func_exit ();
>  			return 1;
>  		}
>  
> -	for (i=0; i < TIMEOUT_2 > 0;i++) {
> +	for (i=0; ((TIMEOUT_2 > 0 ) && (i < TIMEOUT_2 > 0));i++) {
>  		if ((read_sx_byte (board, offset) & mask) == correctval) {
>  			func_exit ();
>  			return 1;
> @@ -548,13 +548,15 @@
>  
>  	func_enter ();
>  
> -	for (i=0; i < TIMEOUT_1 > 0;i++) 
> +	for (i=0; ((TIMEOUT_1 > 0) && (i < TIMEOUT_1));i++) 
> +		if ((read_sx_byte (board, offset) & mask) == correctval) {
>  		if ((read_sx_byte (board, offset) & mask) != badval) {
>  			func_exit ();
>  			return 1;
>  		}
>  
> -	for (i=0; i < TIMEOUT_2 > 0;i++) {
> +	for (i=0; ((TIMEOUT_2 > 0 ) && (i < TIMEOUT_2 > 0));i++) {
> +		if ((read_sx_byte (board, offset) & mask) == correctval) {
>  		if ((read_sx_byte (board, offset) & mask) != badval) {
>  			func_exit ();
>  			return 1;
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
