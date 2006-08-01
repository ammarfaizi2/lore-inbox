Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWHAOtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWHAOtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWHAOtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:49:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54178 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161011AbWHAOtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:49:24 -0400
Message-Id: <200608011449.k71En5VT015262@laptop13.inf.utfsm.cl>
To: Jiri Slaby <jirislaby@gmail.com>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question 
In-Reply-To: Message from Jiri Slaby <jirislaby@gmail.com> 
   of "Tue, 01 Aug 2006 10:51:38 +0159." <44CF1631.3020104@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 01 Aug 2006 10:49:05 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 01 Aug 2006 10:49:06 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
> Heiko Carstens wrote:
> > Hi Andrew,
> > your commit e2c2770096b686b4d2456173f53cb50e01aa635c does this:
> > ---
> > Always use do {} while (0).  Failing to do so can cause subtle compile
> > failures or bugs.
> > -#define hotcpu_notifier(fn, pri)
> > -#define register_hotcpu_notifier(nb)
> > -#define unregister_hotcpu_notifier(nb)
> > +#define hotcpu_notifier(fn, pri)	do { } while (0)
> > +#define register_hotcpu_notifier(nb)	do { } while (0)
> > +#define unregister_hotcpu_notifier(nb)	do { } while (0)
> 
> #if KILLER == 1
> #define MACRO
> #else
> #define MACRO do { } while (0)
> #endif
> 
> {
> 	if (some_condition)
> 		MACRO

                      ;  /* missing */
> 
> 	if_this_is_not_called_you_loose_your_data();
> }

> How do you want to define KILLER, 0 or 1? I personally choose 0.

Yep, at least in this case you'd get a compile failure.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
