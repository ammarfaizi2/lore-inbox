Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUFBSh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUFBSh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUFBSh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:37:57 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:34020 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263709AbUFBShy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:37:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jun 2004 11:37:50 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
In-Reply-To: <20040602182019.GC30427@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl>
 <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org>
 <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org>
 <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com>
 <20040602182019.GC30427@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, [iso-8859-1] Jörn Engel wrote:

> On Wed, 2 June 2004 07:35:39 -0700, Davide Libenzi wrote:
> > 
> > Hmmm, I see more data to maintain to support a method that will never be 
> > even close to be perfect.
> 
> You get it wrong.  This is mainly about Bad Code or Insufficient
> Documentation.  In general, I want recursions to be removed, full
> stop.  So there is not more data, but less.

You're requesting to add and maintain data to feed a tool that catches 
only trivially visible recursion. I don't want to waste mine and your time 
explaining why your tool will never work, but if you want an hint, you can 
start thinking about all functions that sets/pass callbacks and/or sets 
operational functions. I don't know if you noticed that, but Linux is 
heavily function-pointer driven. Eg, one function setups a set of function 
pointers, and another 317 indirectly calls them. Having such comments, not 
only makes the maintainance heavier, but gives the false sense of safeness 
that once you drop that data in, you're protected against recursion.



- Davide

