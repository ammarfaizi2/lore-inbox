Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUFCH37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUFCH37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUFCH37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:29:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:211 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261654AbUFCH3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:29:42 -0400
Date: Thu, 3 Jun 2004 09:29:17 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040603072917.GB20977@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com> <20040602185832.GA2874@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021458090.22742@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406021458090.22742@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 16:20:24 -0700, Davide Libenzi wrote:
> 
> Think at file_operations as very simple example, and try to find out what 
> is actually called when somewhere the code does f_op->*(). How would you 
> build the graph down there. You'd have to record all the functions that 
> have been assigned to such method throughout the code, and nest *all* 
> their graph in place. And this will eventually trigger false positives. 

Bad example, I can deal with that just fine. :)
Any code calling f_op->read must not break for any f_op->read.  So it
is perfectly sane to assume that all get called.  I build the graph by
turning f_op->read into a pseudo-function that calls all functions
ever assigned to f_op->read.

> Similar thing with functions that accepts callbacks, either directly or 
> inside structures.

Those I only handle, if the callbacks are inside structures, true.
Will fix it when I find the time for it.

> And this doesn't even start to take aliasing into 
> account.

What exactly do you call aliasing?  Do you have an example?

> Hunting stack hungry functions is very good, and having a tool 
> that is maybe 60% precise in detecting loops is fine too. But requiring 
> metadata to be maintained to support such tool is IMO wrong.

Since Linus feels that said metadata is still useful without any
tools, I'll just ignore this objection. ;)

Still, some of the complaints were valid, thanks a bunch!  My todo
list has grown again.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
