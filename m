Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRHCQNk>; Fri, 3 Aug 2001 12:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269452AbRHCQNa>; Fri, 3 Aug 2001 12:13:30 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:47627 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S269437AbRHCQNT>; Fri, 3 Aug 2001 12:13:19 -0400
Date: Fri, 3 Aug 2001 12:13:28 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010803121328.A14741@mueller.datastacks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>; from ailinykh@usa.net on Fri, Aug 03, 2001 at 09:57:34AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 03/08/01 09:57 -0600 - Andrey Ilinykh:
> Hi!
> Very often I see in kernel such code as
> do {
>   dosomthing();
> } while(0);

This is a fake function. Macros often use this to give themselves an environment
to allocate stack variables in. Example:

 #define swap(A, B) \
 { \
	int C; \
	C = (A); (A) = (B); (B) = C; \
 } while(0)

swap will now act almost exactly like a function. Please note that this macro
does NOT have a semicolon on the end, as that would cause bad things if I did:

 if (test)
	swap(a,b);
 else
	do_something();

> or even
> #define prepare_to_switch()     do { } while(0)

This is most often found in situations where a code block becomes trivial when
a config option is turned off. The spinlock functions mostly become this when
SMP is not turned on, so they get optimized out of the code.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
