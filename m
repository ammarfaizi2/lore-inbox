Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUFBOpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUFBOpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUFBOpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:45:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:41115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263089AbUFBOpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:45:41 -0400
Date: Wed, 2 Jun 2004 07:45:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602142748.GA25939@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
 <20040602142748.GA25939@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jun 2004, Jörn Engel wrote:
> 
> Then you see something I don't see.  For example there are quite a few
> recursions with some function like
> 
> void foo(int depth)
> {
> 	if (!depth) {
> 		bar(1);
> 	}
> 	...
> }
> 
> bar will, maybe through several more functions call foo(1).
> 
> How can you say that foo will beak this recursion after two rounds
> max?

The programmer had _better_ know that there is some upper limit.

> I claim:
> There is no way to tell the depth of any recursion without looking at
> all involved functions.

And I claim: recursion is illegal unless the programmer has some explicit 
recursion limiter. And if he has that recursion limiter in one of the 
functions, then he damn well better know it, and know the value it limits 
recursion to.

		Linus
