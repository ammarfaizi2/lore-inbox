Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVAYTf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVAYTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVAYTf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:35:29 -0500
Received: from pat.uio.no ([129.240.130.16]:38873 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262086AbVAYTec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:34:32 -0500
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
In-Reply-To: <1106676722.9607.61.camel@winden.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
	 <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de>
	 <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
	 <20050125120507.GH19199@suse.de>
	 <1106671920.11449.11.camel@lade.trondhjem.org>
	 <1106672028.9607.33.camel@winden.suse.de>
	 <1106672637.11449.24.camel@lade.trondhjem.org>
	 <1106673415.9607.36.camel@winden.suse.de>
	 <1106674620.11449.43.camel@lade.trondhjem.org>
	 <1106676722.9607.61.camel@winden.suse.de>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 11:33:57 -0800
Message-Id: <1106681637.11449.101.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.098, required 12,
	autolearn=disabled, AWL 0.10)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 25.01.2005 Klokka 19:12 (+0100) skreiv Andreas Gruenbacher:

> Ah, I see now what you mean. The setxattr syscall only accepts
> well-formed acls (that is, sorted plus a few other restrictions), and
> user-space is expected to take care of that. In turn, getxattr returns
> only well-formed acls. We could lift that guarantee specifically for
> nfs, but I don't think it would be a good idea.

Note that if you really want to add a qsort to the kernel you might as
well drop the setxattr sorting requirement too. If the kernel can qsort
for getxattr, then might as well do it for the case of setxattr too.

> Entry order in POSIX acls doesn't convey a meaning by the way.

Precisely. Are there really any existing programs out there that are
using the raw xattr output and making assumptions about entry order?

> The server must have sorted lists.

So, I realize that the on-disk format is already defined, but looking at
routines like posix_acl_permission(), it looks like the only order the
kernel (at least) actually cares about is that of the "e_tag" field.
Unless I missed something, nothing there cares about the order of the
"e_id" fields.
Given that you only have 6 possible values there, it seems a shame in
hindsight that we didn't choose to just use a 6 bucket hashtable (the
value of e_id being the hash value), and leave the order of the e_id
fields undefined. 8-(

Cheers,
  Trond


-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

