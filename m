Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVALRBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVALRBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 12:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVALRBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 12:01:49 -0500
Received: from pat.uio.no ([129.240.130.16]:9879 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261246AbVALRBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 12:01:47 -0500
Subject: Re: 2.6.10 - VFS is out of sync with lock manager!
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Anders Saaby <as@cohaesio.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501121623.10287.as@cohaesio.com>
References: <200501121623.10287.as@cohaesio.com>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 12:01:34 -0500
Message-Id: <1105549294.14947.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.01.2005 Klokka 16:23 (+0100) skreiv Anders Saaby:

> First issue:
> New strange message in the kernel log:
> 
> "nlmclnt_lock: VFS is out of sync with lock manager!"
> 
> - What does this mean? - Is it bad?, What can i do?

It means that the VFS failed to register the lock that was just granted
to you because of a combination of an RPC race (the reply telling you
the lock was granted arrived before the previous lock holder has been
notified that his lock was freed), and the user pressing ^C at the wrong
moment.

You may have an "orphaned lock" on the server.

> 
> Second issue:
> my fs/nfs/file.c doesn't look like yours (Vanilla 2.6.10):

<shrug>My fs/nfs/file.c looks very much like the one in vanilla
2.6.11-rc1. See Linus' changelog for what may be missing.</shrug>

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

