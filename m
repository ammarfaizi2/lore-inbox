Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268792AbTBZPzB>; Wed, 26 Feb 2003 10:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268786AbTBZPzB>; Wed, 26 Feb 2003 10:55:01 -0500
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:31675 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S268792AbTBZPx6>; Wed, 26 Feb 2003 10:53:58 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: jt@hpl.hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Invalid compilation without -fno-strict-aliasing
References: <200302261538.h1QFcAiF004085@eeyore.valparaiso.cl>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 26 Feb 2003 17:04:05 +0100
In-Reply-To: <200302261538.h1QFcAiF004085@eeyore.valparaiso.cl>
Message-ID: <873cmbghai.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-AntiVirus: checked by AntiVir Milter 1.0.0.8; AVE 6.18.0.2; VDF 6.18.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Jean Tourrilhes <jt@bougret.hpl.hp.com> said:
> > 	if((stream + event_len) < ends) {
> > 		iwe->len = event_len;
> > 		memcpy(stream, (char *) iwe, event_len);
> > 		stream += event_len;
> > 	}
> > 	return stream;
> > }
> 
> The compiler is free to assume char *stream and struct iw_event *iwe
> point to separate areas of memory, due to strict aliasing.

The relevant paragraph of the C99 standard is:

An object shall have its stored value accessed only by an lvalue
expression that has one of the following types:

-- a type compatible with the effective type of the object,
-- a qualified version of a type compatible with the effective type of
   the object,
-- a type that is the signed or unsigned type corresponding to the
   effective type of the object,
-- a type that is the signed or unsigned type corresponding to a
   qualified version of the effective type of the object,
-- an aggregate or union type that includes one of the aforementioned
   types among its members (including, recursively, a member of a
   subaggregate or contained union), or
-- a character type.

I can't really spot any lvalue here that might violate this rule.  It
would be nice if somebody could report a bug with a testcase.

-- 
	Falk
