Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJFRHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJFRHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJFRHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:07:39 -0400
Received: from pat.uio.no ([129.240.130.16]:3052 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751154AbVJFRHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:07:38 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:07:27 -0400
Message-Id: <1128618447.8396.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.931, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 06.10.2005 Klokka 19:02 (+0200) skreiv Miklos Szeredi:
> > The reason why we do it as a lookup intent is because this has to be
> > atomic lookup+create+open in order to be at all useful to NFS.
> > 
> > Just doing create+open atomically is worthless since it leaves you with
> > a bunch of races where someone on the server can create, say, a symlink
> > between the RPC call to lookup and the RPC call that creates the file.
> 
> That's easy to solve: filesystem returns -EAGAIN, namei_open() redoes
> the lookup and continues with the resolving.  There would have to be
> some safeguard counter to avoid infinite loops.

Yech.

> Filesystem could even populate the dentry with the symlink in
> ->open_create() to optimize away the relookup.

Better.

> Do you see a problem with that?

No, but what value does an extra function call add then when you already
have lookup intents?

Cheers,
 Trond

