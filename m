Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTD3R0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTD3R0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:26:01 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:2757 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262227AbTD3R0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:26:01 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dphillips@sistina.com, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 18:43:19 +0200
In-Reply-To: <Pine.LNX.4.44.0304300911420.16712-100000@home.transmeta.com>
Message-ID: <878ytsszq0.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Clearly you're not going to make _one_ load to get fls, since having
> a 4GB lookup array for a 32-bit fls would be "somewhat" wasteful.
> 
> So the lookup table would probably look up just the last 8 bits.
> 
> So the lookup table version is several instructions in itself, doing
> about half of what the calculating version needs to do _anyway_.

Right.

> Including those data-dependent branches.

Well, at least on Alpha, gcc can optimize them all away except one.

Note I'm not really arguing Linux should use a lookup table for fls;
I'm just arguing putting it as default into libgcc for architectures
that don't provide a special version (which aren't particularly many)
isn't stupid. But probably I'm just biased, because I put it there :)

-- 
	Falk
