Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTEDUCQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTEDUCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:02:16 -0400
Received: from pat.uio.no ([129.240.130.16]:63211 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261631AbTEDUCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:02:15 -0400
To: David S Miller <davem@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
References: <20030504191447.C10659@lst.de>
	<16053.20430.903508.188812@charged.uio.no>
	<20030504203655.A11574@lst.de>
	<16053.24599.277205.64363@charged.uio.no>
	<20030504205306.A11647@lst.de>
	<16053.25445.434038.90945@charged.uio.no>
	<1052075166.27465.12.camel@rth.ninka.net>
	<16053.28792.244921.560392@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 May 2003 22:14:36 +0200
In-Reply-To: <16053.28792.244921.560392@charged.uio.no>
Message-ID: <shsbryisc43.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > There don't seem to be any checks and balances to prevent the
     > user from removing the sunrpc module immediately after
     > svc_create_thread() gets called.  I presume that the call to
     > lockd_up() in nfsd() will help (since that calls rpciod_up()
     > and hence MOD_INC_COUNT) but AFAICS there appears to be plenty
     > of possible races before we get to that point.

Sorry. I misread that code. The only nfsd problem goes the other way
round. nfsd() is not exported, and nfsd_svc() does not wait on the
threads to start, hence you have a race between nfsd_svc(), and the
MOD_INC_USE_COUNT inside the nfsd() threads.

Cheers,
  Trond
