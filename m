Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTFNWgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 18:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTFNWgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 18:36:11 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42624 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261188AbTFNWgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 18:36:10 -0400
Date: Sun, 15 Jun 2003 00:49:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.5.68 - Fix gameport_close(gameport); after return in drivers/input/gameport/gameport.c
Message-ID: <20030615004955.A27599@ucw.cz>
References: <200305011610.07281.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200305011610.07281.devenyga@mcmaster.ca>; from devenyga@mcmaster.ca on Thu, May 01, 2003 at 04:10:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 04:10:06PM -0400, Gabriel Devenyi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This patch applies to 2.5.68, it is listed on kbugs.org. The gameport is never closed after calibrating it.
> 
> Please CC me with any discussion.

Thanks, applied.

> - ---FILE---
> 
> - --- linux-2.5.68/drivers/input/gameport/gameport.c	2003-04-19 22:49:31.000000000 -0400
> +++ linux-2.5.68-changed/drivers/input/gameport/gameport.c	2003-05-01 14:57:51.000000000 -0400
> @@ -84,6 +84,7 @@
>  		if ((t = DELTA(t2,t1) - DELTA(t3,t2)) < tx) tx = t;
>  	}
>  
> +	gameport_close(gameport);
>  	return 59659 / (tx < 1 ? 1 : tx);
>  
>  #else
> @@ -93,11 +94,10 @@
>  	j = jiffies; while (j == jiffies);
>  	j = jiffies; while (j == jiffies) { t++; gameport_read(gameport); }
>  
> +	gameport_close(gameport);
>  	return t * HZ / 1000;
>  
>  #endif
> - -
> - -	gameport_close(gameport);
>  }
>  
>  static void gameport_find_dev(struct gameport *gameport)
> 
> - ---ENFILE---
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> 
> iD8DBQE+sX8e7I5UBdiZaF4RAv8DAKCPpHLHADzNWUmRpHrHw7ldAfUdeACgklGx
> 9V+o3A+iUO8Jzb7T1Mr/6eU=
> =EABS
> -----END PGP SIGNATURE-----
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
