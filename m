Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVLTOco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVLTOco (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbVLTOco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:32:44 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44004 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750987AbVLTOco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:32:44 -0500
Message-Id: <200512201428.jBKESAJ5004673@laptop11.inf.utfsm.cl>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from Parag Warudkar <kernel-stuff@comcast.net> 
   of "Mon, 19 Dec 2005 15:17:14 CDT." <D5AD0C5C-CB2C-43AF-913E-23C1FFB1A50C@comcast.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Tue, 20 Dec 2005 11:28:10 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 20 Dec 2005 11:28:12 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
> On Dec 19, 2005, at 2:27 PM, Dumitru Ciobarcianu wrote:
> > but you din't answered my question
> > regarding _which_ os you mentioned needing more stack space and why.

> The two other commercially successful OSes - Windows and Solaris have
> 12Kb and 8Kb default kernel stack sizes. And both seem to do well
> (hold on :) with the large stack sizes - meaning there is no
> commercially observed problem created by the 8K stack size. Solaris
> even lets you change the kernel stack size at runtime.

> Even if we keep aside the impending argument about both OS'es being
> crap 

Right.

>      and we shouldn't be imitating them,

Nodz. That doesn't mean they don't have their strong points, which we
should consider carefully.

>                                          we could still derive one
> conclusion from them - it is possible to have larger stack on i386
> without problems (albeit with some drawbacks) which could be used
> under certain circumstances.

"With some drawbacks" is the point: It has been determined that the
drawbacks are heavy enough that the 8KiB stack option should go. Given
there is /no/ compelling argument /against/ 4KiB stacks, even very minor
drawbacks are important. So first make 4KiB the standard (popular
distributions work that way for /years/ now, with no measurable downsides),
then axe 8KiB stack as an option. Also note that 8KiB stacks really only
gives 4KiB to the process (plus (or minus!) a random ammount depending on
the interrupts being serviced ATM), and this has been so forever.

Oh, well, one of the larger drawbacks of 4KiB stacks is the inevitable
flamewar, each time with /less/ data (this round I've seen none) supporting
the need for larger stacks, into which all kinds of idiots* are suckered.

* This certainly includes myself
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
