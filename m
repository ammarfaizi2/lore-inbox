Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUFBOfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUFBOfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUFBOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:35:46 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:3546 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262974AbUFBOfp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:35:45 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jun 2004 07:35:39 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, Linus Torvalds wrote:

> On Wed, 2 Jun 2004, Jörn Engel wrote:
> > 
> > For a->b->c->a type recursions, I also need to identify all involved
> > functions in the correct order, that's where my ugly format comes
> > from.
> 
> Why?
> 
> You really only need to know that _one_ of the entries break the 
> recursion, and you need to know what the break depth is for that one 
> entry.
> 
> So for example, if "c" is annotated with "max recursion: 5", then you know 
> that the above loop will recurse at most 5 times.
> 
> I don't see why you need any other information.

Hmmm, I see more data to maintain to support a method that will never be 
even close to be perfect. How the thing works with callback triggered 
loops for example, where a function is not directly called, but instead is 
passed to another function (that maybe pass it to another function) that 
triggers the call. Or maybe it's another set of functions that might 
trigger the call (think about all *_operations for example). Eg, there's 
an evident loop possibility in epoll (triggered by callback'd wakeups) 
that is not in the list, and it's pretty hard to detect. Doing stack usage 
analisys from the source code is not easy, once you abbandon the trivial 
direct call scenario.



- Davide

