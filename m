Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWGYOsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGYOsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGYOsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:48:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30698 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932367AbWGYOr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:47:59 -0400
Message-Id: <200607251447.k6PElsf1004520@laptop13.inf.utfsm.cl>
To: "Joshua Hudson" <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: what is necessary for directory hard links 
In-Reply-To: Message from "Joshua Hudson" <joshudson@gmail.com> 
   of "Mon, 24 Jul 2006 21:49:01 MST." <bda6d13a0607242149j4f1492ag47bd8e3e1f0607da@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 25 Jul 2006 10:47:54 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 25 Jul 2006 10:47:55 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson <joshudson@gmail.com> wrote:

[...]

> Maybe someday I'll work out a system by which much less is locked.
> Conceptually, all that is requred to lock for the algorithm
> to work is creating hard-links to directories and renaming directories
> cross-directory.

Some 40 years of filesystem development without finding a solution to that
conundrum would make that quite unlikely, but you are certainly welcome to
try.

> > (which it isn't)
> Counterexample? I should swear that any cycle created by rename must
> pass through the new parent into the victim and back to the new
> parent.

Right. The problem is that the fan-out can be humongous. In the worst case
(which you /have/ to handle right!) you need to look over /all/ the
directories in the filesystem. Meanwhile, you can't allow any operation
that changes the graph. Have you run fsck(8) lately? That should give you
an order-of-magnitude estimate for the time it could take...

Yes, in the "avergage case" it will be much, much less, but that is little
comfort for people who get bitten by "not so average" cases.

Remember that one of the things that made Linus unhappy with Minix was
exactly that the filesystem was single-threaded. Today's requirements for
Linux filesystem performance are /much/ higer than the ones of a lone hobby
user...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
