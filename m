Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287290AbRL3A0D>; Sat, 29 Dec 2001 19:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287286AbRL3AZx>; Sat, 29 Dec 2001 19:25:53 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:21007 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S287292AbRL3AZk>; Sat, 29 Dec 2001 19:25:40 -0500
Date: Sat, 29 Dec 2001 16:25:33 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <andrea@suse.de>, Harald Holzer <harald.holzer@eunet.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <Pine.LNX.4.33.0112291301050.18318-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.33.0112291618290.24475-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, M. Edward (Ed) Borasky wrote:

> On Sat, 29 Dec 2001, Alan Cox wrote:
>
> > Because much of the memory cannot be used for kernel objects there
> > is an imbalance in available resources and its very hard to balance
> > them sanely.  I'm not sure how many 8Gb+ machines Andrea has handy
> > to tune the VM on either.
>
> Along those lines -- I have in front of me the source to
> "/linux/mm/page_alloc.c" (2.4.17 kernel) which reads (partially)

[snip]


> Could someone with a big box and a benchmark that drives it out of
> free memory please try commenting out the "else if" clause and see if
> it makes a difference? I tried this on my puny 512 MB Athlon and
> verified that the right values were there with "sysrq", but I don't
> have anything bigger to try it on and I don't have a benchmark to test
> it with either.

And here it is as a patch against 2.4.17:

diff -ur linux/mm/page_alloc.c linux-2.4.17znmeb/mm/page_alloc.c
--- linux/mm/page_alloc.c	Mon Nov 19 16:35:40 2001
+++ linux-2.4.17znmeb/mm/page_alloc.c	Sat Dec 29 16:04:25 2001
@@ -718,8 +718,13 @@
 		mask = (realsize / zone_balance_ratio[j]);
 		if (mask < zone_balance_min[j])
 			mask = zone_balance_min[j];
+		/* else if clause commented out for testing
+		 * M. Edward Borasky, Borasky Research
+		 * 2001-12-29
+		 *
 		else if (mask > zone_balance_max[j])
 			mask = zone_balance_max[j];
+		 */
 		zone->pages_min = mask;
 		zone->pages_low = mask*2;
 		zone->pages_high = mask*3;


Apologies if pine with vim as the editor messes this puppy up :-).
-- 
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

I brought my inner child to "Take Your Child To Work Day."

