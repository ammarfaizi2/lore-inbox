Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTFXTx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTFXTx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 15:53:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5266 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262202AbTFXTx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 15:53:27 -0400
Message-Id: <200306242006.h5OK6aRY001853@eeyore.valparaiso.cl>
To: corbet@lwn.net (Jonathan Corbet)
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] Allow arbitrary number of init funcs in modules 
In-Reply-To: Your message of "Mon, 23 Jun 2003 13:11:41 CST."
             <20030623191141.31814.qmail@eklektix.com> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Tue, 24 Jun 2003 16:06:36 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corbet@lwn.net (Jonathan Corbet) said:
> --- 2.5.73-rr/kernel/module.c	Tue Jun 24 02:58:32 2003
> +++ 2.5.73/kernel/module.c	Tue Jun 24 03:00:36 2003
> @@ -617,9 +617,10 @@
>  {
>  	int i, balance = 0;
>  
> -	for (i = 0; i < num_pairs; i++)
> +	for (i = 0; i < num_pairs; i++) {
>  		balance += (pairs->init ? 1 : 0) - (pairs->exit ? 1 : 0);
> -
> +		pairs++;
> +	}

Hummm... as you are essentially counting off pairs, isn't there a way of
detecting end-of-pairs, i.e. along the line (last points to NULL):

        for(pairs = start_of_pairs; *pairs; pairs++)
             ....

or just:

        for(i = 0; i < num_pairs; i++)
	       balance += (pairs[i].init ? 1 : 0) - (pairs[i].exit ? 1 : 0);

(as added bonus doesn't screw up variable pairs' value), or even (same as
yours above but marginally clearer IMEHO):

        for (i = 0; i < num_pairs; i++, pairs++)
              .....
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
