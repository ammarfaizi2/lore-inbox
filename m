Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSKNAg4>; Wed, 13 Nov 2002 19:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbSKNAg4>; Wed, 13 Nov 2002 19:36:56 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:33945 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S264733AbSKNAgz>; Wed, 13 Nov 2002 19:36:55 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC93D@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Falk Hueffner'" <falk.hueffner@student.uni-tuebingen.de>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] include/asm-ARCH/page.h:get_order() Reorganize and op
	 timize
Date: Wed, 13 Nov 2002 16:43:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > >     s = --s >> PAGE_SHIFT;
> > > 
> > > This code has undefined behaviour.
> >  
> > Do you mean that this:
> > 
> > s = (s-1) >> PAGE_SHIFT
> > 
> > is more deterministic? If so, I agree -- if you mean something else,
> > I am kind of lost.
> 
> I mean that this code violates the rule that you may modify a value
> only once between two sequence points. Newer gccs have a warning for
> this (-Wsequence-point), the info page tells more.

Agreed, and it was a poor choice from me. (s-1) should be correct,
and gcc-3.2 with -Wsequence-point is happy about it.

> Also, did I understand it right that you want to use fls even on
> architectures that don't have it as a builtin? I would guess that will
> actually be noticeably slower, since generic_fls is so complicated.

Well, it is not that bad, and it is still faster [did a quick test now]

0.144s, 0.241s and 0.358s

[get_order on all numbers from 0 to 90000000 with the optimized version, 
the one that uses generic_fls and the old one].

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

