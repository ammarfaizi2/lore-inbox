Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTD3LCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 07:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTD3LCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 07:02:31 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:28359 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S262023AbTD3LCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 07:02:30 -0400
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: dphillips@sistina.com
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
References: <200304300446.24330.dphillips@sistina.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 30 Apr 2003 13:14:43 +0200
In-Reply-To: <200304300446.24330.dphillips@sistina.com>
Message-ID: <87isswxmn0.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.19.0.3; VDF 6.19.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <dphillips@sistina.com> writes:

> Here's a faster implementation of generic_fls, that I discovered
> accidently, by not noticing 2.5 already had a generic_fls, and so I
> rolled my own.  Like the incumbent, it's O log2(bits), but there's
> not a lot of resemblance beyond that.  I think the new algorithm is
> inherently more parallelizable than the traditional approach.  A
> processor that can speculatively evaluate both sides of a
> conditional would benefit even more than the PIII I tested on.

gcc 3.4 will have a __builtin_ctz function which can be used for this.
It will emit special instructions on CPUs that support it (i386, Alpha
EV67), and use a lookup table on others, which is very boring, but
also faster.

-- 
	Falk
