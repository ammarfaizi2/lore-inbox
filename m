Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbVLWIiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVLWIiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbVLWIiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:38:11 -0500
Received: from pat.uio.no ([129.240.130.16]:3971 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030463AbVLWIiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:38:09 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051223022126.GC22949@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu>
	 <1135293713.3685.9.camel@lade.trondhjem.org>
	 <20051223013933.GB22949@mtholyoke.edu>
	 <1135302325.3685.69.camel@lade.trondhjem.org>
	 <20051223022126.GC22949@mtholyoke.edu>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 09:37:55 +0100
Message-Id: <1135327075.8167.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.672, required 12,
	autolearn=disabled, AWL 1.28, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 21:21 -0500, Ron Peterson wrote:

> Why it doesn't work .. I dunno.  My current best guess is that the
> manner in which the insecure_locks option in /etc/exports is applied to
> directories isn't quite right.

insecure_locks has nothing at all to do with directories. It has to do
with the NLM protocol, which is used by NFSv2/v3 to implement posix
locks.
Directory locking is an entirely separate matter, and is not part of the
NFS protocol (the server will take care of locking the directory when it
needs to modify it without any extra help from the client).

IOW: your problem here has nothing to do with insecure_locks, and
everything to do with your setup. Please double-check that the gid
mappings for the group 'kwc' in /etc/groups match on the client and
server, and note that the default root squashing means that your root
account will get mapped to the user with uid -2 and gid=-2

Cheers,
  Trond

