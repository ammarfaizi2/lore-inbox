Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271033AbTHGWL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 18:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbTHGWL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 18:11:27 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:24525 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S271033AbTHGWL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 18:11:26 -0400
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add identify decoding 4/4
References: <UTC200308062144.h76LiLm16781.aeb@smtp.cwi.nl>
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Date: 07 Aug 2003 18:11:03 -0400
In-Reply-To: <UTC200308062144.h76LiLm16781.aeb@smtp.cwi.nl>
Message-ID: <m1n0eljeyw.fsf@pincoya.inf.utfsm.cl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl writes:
> > I know full well _why_ the big function is in the header;
> > that doesn't address my point:  we don't need to be putting
> > big functions in header files.  That's why libraries were invented
> 
> Well. I chose the most elegant solution I saw.
> 
> If you see a better solution, I would like to see it.
> Note that local symbols in several files determine
> whether this function should be compiled or not.

Then the proposed solution won't work either...

Just do an xyz.h:

#ifdef NEED_BIG_UGLY_FUNC
/* Prototype, gets pulled in when called */
void big_ugly_func(int this, void *that);
#else
/* Inline definition, gets nuked */
static inline void big_ugly_func(int this, void *that) {}
#endif

while xyz.c goes into a library (*.a) with the full definition. Gets
compiled, but not linked in.

What is wrong with that?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
