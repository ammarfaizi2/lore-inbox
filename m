Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbUAFRiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbUAFRiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:38:08 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:17544 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264870AbUAFRhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:37:48 -0500
Date: Tue, 6 Jan 2004 18:37:40 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: torvalds@osdl.org, James.Bottomley@SteelEye.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
In-Reply-To: <20040106092237.4e617296.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0401061832360.9228@gockel.physik3.uni-rostock.de>
References: <1073405053.2047.28.camel@mulgrave> <20040106081947.3d51a1d5.akpm@osdl.org>
 <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
 <Pine.LNX.4.53.0401061807070.9108@gockel.physik3.uni-rostock.de>
 <20040106092237.4e617296.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Andrew Morton wrote:

> Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >
> >   #if (BITS_PER_LONG < 64)
> >  @@ -21,7 +21,7 @@
> >   #else
> >   static inline u64 get_jiffies_64(void)
> >   {
> >  -	return (u64)jiffies;
> >  +	return jiffies_64;
> >   }
> >   #endif
> 
> hm, why this change?  Are you sure that all 64-bit architectures alias
> jiffies onto jiffies_64?  x86_64 seems not to.
> 

It was jiffies_64 in the first place (that's why the function is called
get_jiffies_64(), after all). 
I once made it jiffies because jiffies was volatile while jiffies_64 was
not. Now that jiffies_64 becomes volatile as well, I thought we could
re-straighten things.

But we can leave out this chunk, it really shouldn't make any difference.

Tim
