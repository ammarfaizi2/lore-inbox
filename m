Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUECQLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUECQLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUECQLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:11:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1221 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263772AbUECQLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:11:42 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.28383.871208.542553@segfault.boston.redhat.com>
Date: Mon, 3 May 2004 12:10:07 -0400
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm1
In-Reply-To: <Pine.LNX.4.58.0405032250060.4454@donald.themaw.net>
References: <20040430014658.112a6181.akpm@osdl.org>
	<Pine.LNX.4.58.0405032250060.4454@donald.themaw.net>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: 2.6.6-rc3-mm1; raven@themaw.net adds:

raven> The case where two process similtaneously trigger a mount in autofs4
raven> can cause multiple requests to the daemon for the same mount. The
raven> daemon handles this OK but it's possible an incorrect error to be
raven> returned. For this reason I believe it is better to change the spin
raven> lock to a semaphore in waitq.c. This makes the second and subsequent
raven> request wait on the q as ther supposed to.

This looks good to me.  Do you also need to take the semaphore in
autofs4_catatonic_mode(), around the hijacking of the queue?

void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
{
	struct autofs_wait_queue *wq, *nwq;

	DPRINTK(("autofs: entering catatonic mode\n"));

	sbi->catatonic = 1;
	wq = sbi->queues;
	sbi->queues = NULL;	/* Erase all wait queues */
...


-Jeff
