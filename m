Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTEDToV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTEDToV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:44:21 -0400
Received: from pat.uio.no ([129.240.130.16]:22501 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261624AbTEDToU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:44:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.28792.244921.560392@charged.uio.no>
Date: Sun, 4 May 2003 21:56:40 +0200
To: David S Miller <davem@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
In-Reply-To: <1052075166.27465.12.camel@rth.ninka.net>
References: <20030504191447.C10659@lst.de>
	<16053.20430.903508.188812@charged.uio.no>
	<20030504203655.A11574@lst.de>
	<16053.24599.277205.64363@charged.uio.no>
	<20030504205306.A11647@lst.de>
	<16053.25445.434038.90945@charged.uio.no>
	<1052075166.27465.12.camel@rth.ninka.net>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually. Looking around at the server side, there appear to be a
couple of potential problems too...

There don't seem to be any checks and balances to prevent the user
from removing the sunrpc module immediately after svc_create_thread()
gets called.
I presume that the call to lockd_up() in nfsd() will help (since that
calls rpciod_up() and hence MOD_INC_COUNT) but AFAICS there appears to
be plenty of possible races before we get to that point.

Cheers,
  Trond
