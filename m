Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264754AbTB0Lxv>; Thu, 27 Feb 2003 06:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTB0Lxv>; Thu, 27 Feb 2003 06:53:51 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38876 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S264754AbTB0Lxu>;
	Thu, 27 Feb 2003 06:53:50 -0500
Message-Id: <200302262104.h1QL4aiC001941@eeyore.valparaiso.cl>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       vonbrand@eeyore.valparaiso.cl
Subject: Re: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface 
In-Reply-To: Your message of "Wed, 26 Feb 2003 17:09:27 -0000."
             <20030226170927.GC8369@fib011235813.fsnet.co.uk> 
Date: Wed, 26 Feb 2003 18:04:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber <joe@fib011235813.fsnet.co.uk> said:
> Use the correct size for "name" in register_with_devfs().
> 
> During Al Viro's devfs cleanup a few versions ago, this function was
> rewritten, and the "name" string added. The 32-byte size is not large
> enough to prevent a possible buffer overflow in the sprintf() call,
> since the hash cell can have a name up to 128 characters.
> 
> [Kevin Corry]
> 
> --- diff/drivers/md/dm-ioctl.c	2003-02-26 16:09:42.000000000 +0000
> +++ source/drivers/md/dm-ioctl.c	2003-02-26 16:09:52.000000000 +0000
> @@ -173,7 +173,7 @@
>   */
>  static int register_with_devfs(struct hash_cell *hc)
>  {
> -	char name[32];
> +	char name[DM_NAME_LEN + strlen(DM_DIR) + 1];

This either makes a large name array or generates a possibly huge array at
runtime (bad if your stack is < 8KiB).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
