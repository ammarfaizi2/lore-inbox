Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTD3N6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 09:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTD3N6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 09:58:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14084 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262191AbTD3N6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 09:58:52 -0400
Date: Wed, 30 Apr 2003 07:11:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <87isswxmn0.fsf@student.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.44.0304300709300.7157-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Apr 2003, Falk Hueffner wrote:
> 
> gcc 3.4 will have a __builtin_ctz function which can be used for this.
> It will emit special instructions on CPUs that support it (i386, Alpha
> EV67), and use a lookup table on others, which is very boring, but
> also faster.

Classic mistake. Lookup tables are only faster in benchmarks, they are
almost always slower in real life. You only need to miss in the cache
_once_ on the lookup to lose all the time you won on the previous one
hundred calls.

"Small and simple" is almost always better than the alternatives. I 
suspect that's one reason why older versions of gcc often generate code 
that actually runs faster than newer versions: the newer versions _look_ 
like they do a better job, but..

			Linus

