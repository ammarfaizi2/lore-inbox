Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTLDNib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTLDNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:38:31 -0500
Received: from shark.pro-futura.com ([161.58.178.219]:37021 "EHLO
	shark.pro-futura.com") by vger.kernel.org with ESMTP
	id S262126AbTLDNiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:38:19 -0500
From: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko@croadria.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.4.23-ck1
Date: Thu, 4 Dec 2003 14:36:57 +0100
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200312040228.44980.kernel@kolivas.org> <200312042321.44902.kernel@kolivas.org> <Pine.LNX.4.53.0312041421300.9854@gockel.physik3.uni-rostock.de>
In-Reply-To: <Pine.LNX.4.53.0312041421300.9854@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041436.57450.tvrtko@croadria.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 14:31, Tim Schmielau wrote:

> Warning: totally untested. Pretty much obvious, however.

oxygene:/usr/src/linux-2.4.23-ck1 # patch --dry-run 
<../patches/2.4.23-ck1-stat-fix.patch -p1 --global-reject=bla
patching file fs/proc/proc_misc.c
Hunk #1 FAILED at 422.
Hunk #2 FAILED at 460.
2 out of 2 hunks FAILED -- saving rejects to file fs/proc/proc_misc.c.rej

oxygene:/usr/src/linux-2.4.23-ck1 # cat bla
*************** fs/proc/proc_misc.c
*** 422,428 ****
                         (unsigned long long) jiffies_64_to_clock_t(user),
                         (unsigned long long) jiffies_64_to_clock_t(nice),
                         (unsigned long long) jiffies_64_to_clock_t(system),
-                        (unsigned long long) jiffies_64_to_clock_t(jif - user 
-
 nice - system));
         }
         proc_sprintf(page, &off, &len,
                 "page %u %u\n"
--- 422,428 ----
                         (unsigned long long) jiffies_64_to_clock_t(user),
                         (unsigned long long) jiffies_64_to_clock_t(nice),
                         (unsigned long long) jiffies_64_to_clock_t(system),
+                        (unsigned long long) jif - jiffies_64_to_clock_t(user 
+
 nice + system));
         }
         proc_sprintf(page, &off, &len,
                 "page %u %u\n"
*************** fs/proc/proc_misc.c
*** 460,466 ****
                 }
         }

-        do_div(jif, HZ);
         proc_sprintf(page, &off, &len,
                 "\nctxt %lu\n"
                 "btime %lu\n"
--- 460,466 ----
                 }
         }

+        do_div(jif, USER_HZ);
         proc_sprintf(page, &off, &len,
                 "\nctxt %lu\n"
                 "btime %lu\n"



> Sorry,
> Tim
>
>
> --- linux-2.4.23-ck1/fs/proc/proc_misc.c	2003-12-04 14:15:59.000000000
> +0100 +++ linux-2.4.23-ck1-fix/fs/proc/proc_misc.c	2003-12-04
> 14:20:07.000000000 +0100 @@ -422,7 +422,7 @@
>  			(unsigned long long) jiffies_64_to_clock_t(user),
>  			(unsigned long long) jiffies_64_to_clock_t(nice),
>  			(unsigned long long) jiffies_64_to_clock_t(system),
> -			(unsigned long long) jiffies_64_to_clock_t(jif - user - nice -
> system)); +			(unsigned long long) jif - jiffies_64_to_clock_t(user + nice
> + system)); }
>  	proc_sprintf(page, &off, &len,
>  		"page %u %u\n"
> @@ -460,7 +460,7 @@
>  		}
>  	}
>
> -	do_div(jif, HZ);
> +	do_div(jif, USER_HZ);
>  	proc_sprintf(page, &off, &len,
>  		"\nctxt %lu\n"
>  		"btime %lu\n"

