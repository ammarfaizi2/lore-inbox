Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265193AbUFAT7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUFAT7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265187AbUFAT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:59:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:19896 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265193AbUFAT6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:58:44 -0400
Date: Tue, 1 Jun 2004 12:58:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Pavel Machek <pavel@suse.cz>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count 
In-Reply-To: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Jun 2004, Horst von Brand wrote:
> 
> If the comment gets out of sync, you are toast. Too easy for that to
> happen, IMVHO.

Yes.

Recursion should be detectable automatically, the only thing you can't 
detect easily is the reason to _break_ recursion. 

So how about just having a simple loop finder, and then the only comment 
you need is a simple /* max recursion: N */ for any point in the loop.

That still makes it interesting if one function is part of two loops, and
is logically the place that breaks the recursion for one (or both - with
different logic) of them. But does that actually happen?

			Linus
