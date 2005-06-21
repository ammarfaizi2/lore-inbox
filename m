Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVFUVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVFUVUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFUVRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 17:17:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45983 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262394AbVFUVMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:12:53 -0400
Message-Id: <200506212112.j5LLCG7V031031@laptop11.inf.utfsm.cl>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Domen Puncer <domen@coderock.org>
Subject: Re: [RFC] cleanup patches for strings 
In-Reply-To: Message from Jesper Juhl <juhl-lkml@dif.dk> 
   of "Tue, 21 Jun 2005 00:46:26 +0200." <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 21 Jun 2005 17:12:16 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 21 Jun 2005 17:12:17 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
> I have a bunch (few hundred) of oneliners like the ones below lying around 
> on my HD and I'm wondering what the best way to submit them is.
> 
> The patches all make the same change, there's just a lot of files the 
> change needs to be made in.  The change they make is to change strings 
> from the form
> 	[const] char *foo = "blah";
> to
> 	[const] char foo[] = "blah";
> 
> The reason to do this was well explained by Jeff Garzik in the past (and 
> now found in the Kernel Janitors TODO) :

Which is dead wrong. A short test program here (Fedora rawhide, i686,
gcc-4.0.0) shows that if you use an array, it is allocated on the stack and
the contents of the (constant, readonly) string is copied there before use,
just as you'd have to expect given C's semantics. I.e., the function gets
larger, slower, and uses more stack. If the array is declared const makes
no difference (AFAIR, it can't, as the const doesn't guarantee it won't be
changed).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

