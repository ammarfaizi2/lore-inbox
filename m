Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUFBOSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUFBOSq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUFBOSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:18:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:12936 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbUFBOPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:15:45 -0400
Date: Wed, 2 Jun 2004 07:15:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602131623.GA23017@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Jun 2004, Jörn Engel wrote:
> 
> For a->b->c->a type recursions, I also need to identify all involved
> functions in the correct order, that's where my ugly format comes
> from.

Why?

You really only need to know that _one_ of the entries break the 
recursion, and you need to know what the break depth is for that one 
entry.

So for example, if "c" is annotated with "max recursion: 5", then you know 
that the above loop will recurse at most 5 times.

I don't see why you need any other information.

			Linus
