Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTEDRYz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbTEDRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 13:24:55 -0400
Received: from pat.uio.no ([129.240.130.16]:51123 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261231AbTEDRYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 13:24:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.20430.903508.188812@charged.uio.no>
Date: Sun, 4 May 2003 19:37:18 +0200
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
In-Reply-To: <20030504191447.C10659@lst.de>
References: <20030504191447.C10659@lst.de>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christoph Hellwig <hch@lst.de> writes:

     >  - rpciod() (the ernel thread) also bumps the refcount when starting
     >    and decrements it when exiting.  but as a different module
     >    must initiate this using rpciod_up/rpciod_down this is again
     >    not needed.  (except when a module does rpciod_up without a
     >    matching rpciod_down - but that a big bug anyway and we
     >    don't need to partially handle that using module refcounts).


There's another case which you appear to be ignoring: rpciod_down() is
interruptible and does not have to wait on the rpciod() thread to
complete.

Cheers,
  Trond
