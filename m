Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133001AbRDLMjX>; Thu, 12 Apr 2001 08:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133015AbRDLMjN>; Thu, 12 Apr 2001 08:39:13 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:36871 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S133001AbRDLMjF>; Thu, 12 Apr 2001 08:39:05 -0400
Message-Id: <200104121238.f3CCcZHQ030519@pincoya.inf.utfsm.cl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first 
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Thu, 12 Apr 2001 01:55:16 MST." <20010412015516.A335@baldur.yggdrasil.com> 
Date: Thu, 12 Apr 2001 08:38:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said:

[...]

> 	I suppose that running the child first also has a minor
> advantage for clone() in that it should make programs that spawn lots
> of threads to do little bits of work behave better on machines with a
> small number of processors, since the threads that do so little work that
> they accomplish they finish within their time slice will not pile up
> before they have a chance to run.  So, rather than give the parent's CPU
> priority to the child only if CLONE_VFORK is not set, I have decided to
> do a bit of machete surgery and have the child always inherit all of the
> parent's CPU priority all of the time.  It simplifies the code and
> probably saves a few clock cycles (and before you say that this will
> cost a context switch, consider that the child will almost always run
> at least one time slice anyhow).

And opens the system up to DoS attacks: You can't have a process fork(2)
at will and so increase its (aggregate) CPU priority.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
