Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265651AbUFCQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUFCQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUFCQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:39:56 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:11735 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S265652AbUFCQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:39:53 -0400
Date: Thu, 3 Jun 2004 18:39:45 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
In-Reply-To: <20040603015356.709813e9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0406031826410.7969@gockel.physik3.uni-rostock.de>
References: <20040603015356.709813e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +bsd-acct-warning-fix.patch
> 
>  Fix warning in the BSD accounting patch

Thanks for educating me one this.

I vaguely remember someone wrote on lkml that defining variables in blocks
was bad because some gcc version wouldn't deal well with it. This was just
at the time I wrote these lines, so I refrained from it in spite of the
warning. OTOH, this is so very basic C that I cannot imagine gcc getting
it wrong.


There is one other mistake in the BSD accounting patch, fixed below 
(thanks to Peter Lundkvist for reporting).

Then there's the thing with units of time not exactly corresponding to
USER_HZ anymore.

And it seems this didn't get much outside testing yet, since I've only 
recently seen the first download of the userspace tools. Well, BSD 
accounting isn't too exciting these days...


I'll probably roll up another version before this can hit mainline.

Tim


--- linux-2.6.7-rc2-acct1/include/linux/acct.h	2004-06-03 18:21:47.000000000 +0200
+++ linux-2.6.7-rc2-acct2/include/linux/acct.h	2004-06-03 18:21:55.000000000 +0200
@@ -165,7 +165,7 @@ static inline u64 jiffies_64_to_AHZ(u64 
 {
 #if HZ == AHZ
 	/* do nothing */
-#elseif (HZ % AHZ)==0
+#elif (HZ % AHZ)==0
 	do_div(x, HZ / AHZ);
 #else
 	x *= AHZ;
