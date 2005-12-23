Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbVLWU6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbVLWU6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbVLWU6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 15:58:50 -0500
Received: from pat.uio.no ([129.240.130.16]:8423 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161051AbVLWU6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 15:58:49 -0500
Subject: Re: nfs insecure_locks / Tru64 behaviour
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1EprNK-0005ZC-00@calista.inka.de>
References: <E1EprNK-0005ZC-00@calista.inka.de>
Content-Type: text/plain
Date: Fri, 23 Dec 2005 21:58:40 +0100
Message-Id: <1135371520.8555.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.7, required 12,
	autolearn=disabled, AWL 2.25, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 19:10 +0100, Bernd Eckenfels wrote:
> In article <20051223013933.GB22949@mtholyoke.edu> you wrote:
> > That's exactly the problem.  The first obvious solution doesn't work.
> > Your second solution does.  The directory must have the execute bit set
> > for other, or the the file cannot be edited, no matter who owns the
> > directory (unless the owner/group is nobody/nogroup).
> 
> Is it a edit problem or a directory-enter problem (i.e. can you do a "cd d"?).
> 
> Is it a general file access problem or only with vi (i.e. can do "echo bla >> file")
> 
> If it is a vi specific problem maybe the locking is the problem:
> 
> The insecure_locks on Linux server is  needed, cause Linux NFS Server will
> serve lock requests normally only from root users, and True64 requests from
> unpriveledged daemon user. This means fctnl locking cannot be done, and this
> might be a problem for vi.

Huh? No it doesn't. The Linux NLM server requires that the client
authenticate using AUTH_SYS (unless you use insecure_locks), but it
certainly doesn't require you to have root privileges. That would
violate POSIX locking rules.

Cheers,
  Trond

