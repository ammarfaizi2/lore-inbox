Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVBOWsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVBOWsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVBOWsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:48:12 -0500
Received: from pat.uio.no ([129.240.130.16]:40135 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261926AbVBOWot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:44:49 -0500
Subject: Re: [patch 10/13] Solaris nfsacl workaround
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050215203553.GA34621@dspnet.fr.eu.org>
References: <20050122203326.402087000@blunzn.suse.de>
	 <20050122203619.889966000@blunzn.suse.de>
	 <1108488547.10073.39.camel@lade.trondhjem.org>
	 <20050215203553.GA34621@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 17:43:24 -0500
Message-Id: <1108507404.10073.228.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.984, required 12,
	autolearn=disabled, AWL 2.02, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 15.02.2005 Klokka 21:35 (+0100) skreiv Olivier Galibert:
> That's the second time I see you refusing an interoperability patch
> without bothering to say what would be acceptable.  Do we need a fork
> between knfsd-pure and knfsd-actually-works-in-the-real-world or what?

You appear to be under the misguided impression that if a patch is
reviewed, and rejected, then somehow the responsibility for resolving
your problem (and cleaning up the code) falls to the reviewer.

I'm not aware of any such rule.


Feel free to apply as many hacks as you like to your own private fork,
but the mainline kernel has to be maintained by a community of people
most of which will not be aware, when debugging the ACL code, of the
little special cases peppered around the RPC server code in an entirely
different section of the kernel.

In this particular case, there are 100s of solutions that do not involve
putting NFSv3 ACL code in the generic RPC layer. If there really is a
generic need for RPC programs to override the RFC-specified error that
is returned to the client, then one obvious solution is to add a
callback that allows them to do so.

Even a flag called RPC_SVC_DO_NOT_EVER_RETURN_BAD_VERS would be easier
to maintain.

  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

