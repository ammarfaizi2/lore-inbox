Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbTCLP3X>; Wed, 12 Mar 2003 10:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCLP3X>; Wed, 12 Mar 2003 10:29:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10768 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261726AbTCLP3W>; Wed, 12 Mar 2003 10:29:22 -0500
Date: Wed, 12 Mar 2003 07:38:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Szakacsits Szabolcs <szaka@sienet.hu>
cc: Richard Henderson <rth@twiddle.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <Pine.LNX.4.30.0303121101590.17436-100000@divine.city.tvnet.hu>
Message-ID: <Pine.LNX.4.44.0303120735410.13807-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Mar 2003, Szakacsits Szabolcs wrote:
> 
> Some data points, in time order.
> 
> SuSE 8.0 	2.95.3-216      no bug yet [1]
> Debian 3.0      2.95.4-14       no bug yet [1]
> Red Hat 7.[23]  2.96-81         no bug yet [2,3]
> Red Hat 7.[23]  2.96-98         bug introduced [2,3]
> Mandrake 8.1    2.96-0.62mdk    bug introduced [4]
> Red Hat 7.[23]  2.96-103        bug fixed  [2,3]
> SuSE 8.0        3.0.4 (SuSE)    bug fixed [1]
> Mandrake 9.1    3.2.2-2mdk      bug fixed [1]

Ok. So the test really is for one particular version only.

That's easy. I'll just add a

	#ifdef CONFIG_FRAME_POINTER
	#if __GNUC__ == 2 && __GNUC_MINOR__ == 96
	#error This compiler is not safe with frame pointers
	#endif
	#endif

to <linux/compiler.h>. Yeah, it will get some fixed compilers too, but 
that's just not worth worrying about - people will just have to turn off 
CONFIG_FRAME_POINTER and be happy.

		Linus

