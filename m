Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSKNATi>; Wed, 13 Nov 2002 19:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSKNATh>; Wed, 13 Nov 2002 19:19:37 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:3210 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264699AbSKNATg>; Wed, 13 Nov 2002 19:19:36 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-ARCH/page.h:get_order() Reorganize and op timize
References: <A46BBDB345A7D5118EC90002A5072C7806CAC93A@orsmsx116.jf.intel.com>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 14 Nov 2002 01:26:08 +0100
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC93A@orsmsx116.jf.intel.com>
Message-ID: <87u1ilov33.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> writes:

> > >     s = --s >> PAGE_SHIFT;
> > 
> > This code has undefined behaviour.
>  
> Do you mean that this:
> 
> s = (s-1) >> PAGE_SHIFT
> 
> is more deterministic? If so, I agree -- if you mean something else,
> I am kind of lost.

I mean that this code violates the rule that you may modify a value
only once between two sequence points. Newer gccs have a warning for
this (-Wsequence-point), the info page tells more.

Also, did I understand it right that you want to use fls even on
architectures that don't have it as a builtin? I would guess that will
actually be noticeably slower, since generic_fls is so complicated.

-- 
	Falk
