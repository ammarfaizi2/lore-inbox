Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWGUStQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWGUStQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWGUStQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 14:49:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59849 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750885AbWGUStP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 14:49:15 -0400
Message-Id: <200607211849.k6LInCi8011368@laptop13.inf.utfsm.cl>
To: "Joshua Hudson" <joshudson@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links 
In-Reply-To: Your message of "Thu, 20 Jul 2006 18:04:49 MST."
             <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 21 Jul 2006 14:49:12 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 21 Jul 2006 14:49:12 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:
> This patch is the sum total of all that I had to change in the kernel
> VFS layer to support hard links to directories

Can't be done, as it creates the possibility of loops. The "only files can
be hardlinked" idea makes garbage collection (== deleting of unreachable
objects) simple: Just check the number of references.

Detecting unconnected subgraphs uses a /lot/ of memory; and much worse, you
have to stop (almost) all filesystem activity while doing it.

Besides, the flow "root down through directories" gives a natural order in
which to go locking stuff when needed; if there can be loops, the system
could easily deadlock.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

