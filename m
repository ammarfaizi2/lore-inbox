Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVAYRhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVAYRhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVAYRhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:37:31 -0500
Received: from pat.uio.no ([129.240.130.16]:11425 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262019AbVAYRhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:37:24 -0500
Subject: Re: [patch 1/13] Qsort
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Olaf Kirch <okir@suse.de>, Andi Kleen <ak@muc.de>,
       Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
In-Reply-To: <1106673415.9607.36.camel@winden.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
	 <1106672028.9607.33.camel@winden.suse.de>
	 <1106672637.11449.24.camel@lade.trondhjem.org>
	 <1106673415.9607.36.camel@winden.suse.de>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 09:37:00 -0800
Message-Id: <1106674620.11449.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12,
	autolearn=disabled)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 25.01.2005 Klokka 18:16 (+0100) skreiv Andreas Gruenbacher:

> > Whatever Sun chooses to do or not do changes nothing to the question of
> > why our client would want to do a quicksort in the kernel.
> 
> Well, it determines what we must accept, both on the server side and the
> client side.

I can see why you might want it on the server side, but I repeat: why
does the client need to do this in the kernel? The client code should
not be overriding the server when it comes to what is acceptable or not
acceptable. That's just wrong...

I can also see that if the server _must_ have a sorted list, then doing
a sort on the client is a good thing since it will cut down on the work
that said server will need to do, and so it will scale better with the
number of clients (though note that, conversely, this server will scale
poorly with the Sun clients or others if they do not sort the lists).

I'm asking 'cos if the client doesn't need this code, then it seems to
me you can move helper routines like the quicksort and posix checking
routines into the nfsd module rather than having to keeping it in the
VFS (unless you foresee that other modules will want to use the same
routines???).

Cheers,
 Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

