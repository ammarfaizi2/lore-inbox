Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUC3AUu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUC3AUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:20:50 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:57987 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263289AbUC3AUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:20:45 -0500
Subject: Re: [patch] silence nfs mount messages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040329234643.GB17179@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
	 <1080587480.2410.61.camel@lade.trondhjem.org>
	 <20040329195435.GA19426@apps.cwi.nl>
	 <1080602653.2410.192.camel@lade.trondhjem.org>
	 <20040329234643.GB17179@apps.cwi.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080606053.2410.260.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 19:20:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 18:46, skreiv Andries Brouwer:
> The present situation is that the kernel comes with messages when
> mount is recent and the kernel is old, and also when the kernel
> is recent and mount is old. I object to both.
> 
> Mount tries the latest version it knows about, when that fails
> goes back to an earlier version until either the mount succeeds
> or we give up. The same binary must work over a large range of
> kernel versions.

That will break functionality for the user, and sounds like a bug in
"mount". See my objection w.r.t. the user who thinks he is getting
secure authentication via RPCSEC_GSS.

> If you think that it would be terrible to have a nfs-v3 mount
> succeed on a kernel that knows about nfs-v4 then I would prefer
> to change the name of the filesystem to nfs4.

The changes you are complaining about have *NOTHING* whatsoever to do
with NFSv4, which already has its own filesystem name (yes: it is called
"nfs4") with its own struct nfs4_mount.


The 2 changes to the NFSv2/v3 mount structure are as follows:

        int             pseudoflavor;           /* 5 */
        char            context[NFS_MAX_CONTEXT_LEN + 1];       /* 6 */

"pseudoflavor" adds support for the RPCSEC_GSS authentication flavours,
so that people can use it for improving NFSv2/v3 security.

"context" is an SELinux construct for passing their security context
information (whatever that may be) down to their private handler.

See? no NFSv4...

Cheers,
  Trond
