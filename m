Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266609AbSKUM5d>; Thu, 21 Nov 2002 07:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbSKUM5d>; Thu, 21 Nov 2002 07:57:33 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61841 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266609AbSKUM5c>;
	Thu, 21 Nov 2002 07:57:32 -0500
Date: Thu, 21 Nov 2002 13:00:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5] Add TAINT_UNKNOWN_STATE
Message-ID: <20021121130052.GB9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44.0211210250330.1628-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211210250330.1628-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:55:44AM -0500, Zwane Mwaikambo wrote:
 > --- linux-2.5.48/include/linux/kernel.h	18 Nov 2002 05:11:13 -0000	1.1.1.1
 > +++ linux-2.5.48/include/linux/kernel.h	20 Nov 2002 06:29:39 -0000
 > @@ -103,6 +103,7 @@
 >  #define TAINT_FORCED_MODULE		(1<<1)
 >  #define TAINT_UNSAFE_SMP		(1<<2)
 >  #define TAINT_FORCED_RMMOD		(1<<3)
 > +#define TAINT_UNKNOWN_STATE		(1<<4)
 >  
 >  extern void dump_stack(void);
 >  
 > Index: linux-2.5.48/kernel/panic.c
 > ===================================================================
 > RCS file: /build/cvsroot/linux-2.5.48/kernel/panic.c,v
 > retrieving revision 1.1.1.1
 > diff -u -r1.1.1.1 panic.c
 > --- linux-2.5.48/kernel/panic.c	18 Nov 2002 05:13:12 -0000	1.1.1.1
 > +++ linux-2.5.48/kernel/panic.c	21 Nov 2002 07:30:10 -0000
 > @@ -114,10 +114,11 @@
 >  {
 >  	static char buf[20];
 >  	if (tainted) {
 > -		snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
 > +		snprintf(buf, sizeof(buf), "Tainted: %c%c%c%c",
 >  			tainted & TAINT_PROPRIETORY_MODULE ? 'P' : 'G',
 >  			tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
 > -			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
 > +			tainted & TAINT_UNSAFE_SMP ? 'S' : ' ',
 > +			tainted & TAINT_UNKNOWN_STATE ? 'U' : ' ');
 >  	}

 While you're in panic.c, want to add the missing flag for 
 TAINT_FORCED_RMMOD that Rusty missed ? Maybe 'R' ?

		Dave
		 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
