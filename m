Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271638AbRHQM1G>; Fri, 17 Aug 2001 08:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271639AbRHQM0q>; Fri, 17 Aug 2001 08:26:46 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:5560 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S271638AbRHQM0k>; Fri, 17 Aug 2001 08:26:40 -0400
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
In-Reply-To: <997973469.7632.10.camel@pc-16> <998035017.663.13.camel@phantasy> <998035444.7627.4.camel@pc-16.office.scali.no> <998035750.1013.15.camel@phantasy> <998036130.7627.12.camel@pc-16.office.scali.no>
From: michael@optusnet.com.au
Date: 17 Aug 2001 22:26:25 +1000
In-Reply-To: Terje Eggestad's message of "17 Aug 2001 10:15:30 +0200"
Message-ID: <m1y9oic1ou.fsf@mo.optusnet.com.au>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why not just print out the address of the 'mm_struct'? 

That lets 'ps' treat the address as a cookie, and
thus count the number of occurences of each vm.

This has the additional advantages of:

* moving the intelligence out to the app
* reducing the kernel size, and
* make it easy to find out exactly which processes
are using which vm. (you just search for all occurences
of the cookie).

Michael.


Terje Eggestad <terje.eggestad@scali.no> writes:
> --=-L6iLOYILsDzljNLIi035
> Content-Type: text/plain
> Content-Transfer-Encoding: 7bit
> --- array.c.orig	Mon Mar 19 21:34:55 2001
> +++ array.c	Thu Aug 16 16:33:56 2001
> @@ -50,6 +50,12 @@
>   * Al Viro & Jeff Garzik :  moved most of the thing into base.c and
>   *			 :  proc_misc.c. The rest may eventually go into
>   *			 :  base.c too.
> + *
> + * Terje Eggestad    :  added in /proc/<pid>/status a VmClones: n
> + *                   :  that tells how many proc that uses the same VM (mm_struct).
> + *                   :  if there are clones add another field VmFirstClone with the
> + *                   :  clone with the lowest pid. Needed for things like gtop that adds 
> + *                   :  mem usage of groups of proc, or else they add up the usage of threads.
>   */
