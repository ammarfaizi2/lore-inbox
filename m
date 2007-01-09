Return-Path: <linux-kernel-owner+w=401wt.eu-S932226AbXAIQkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbXAIQkK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbXAIQkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:40:10 -0500
Received: from pat.uio.no ([129.240.10.15]:40760 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932226AbXAIQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:40:07 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Kara <jack@suse.cz>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
In-Reply-To: <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>
References: <20070108111852.ee156a90.akpm@osdl.org>
	 <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
	 <20070109122644.GB1260@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:39:38 -0500
Message-Id: <1168360778.6054.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: B86ADEB2AC86ED95E454111815EB93F2A7184130
X-UiO-SPAM-Test: 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 13:26 +0100, Jan Kara wrote:
>   Yes, making fs readonly at VFS level would not work for already opened
> files. But you if you create new union, you could lock down the
> filesystems you are unioning (via s_umount semaphore), go through lists
> of all open fd's on those filesystems and check whether they are open
> for write or not. If some fd is open for writing, you simply fail to
> create the union (and it's upto user to solve the problem). Otherwise
> you mark filesystems as RO and safely proceed with creating the union.
> I guess you must have come up with this solution. So what is the problem
> with it?

Aside from the fact that this is racy (s_umount doesn't protect you
against a process opening a new file while you are busy running through
the open fds to see if you can reset the MS_RDONLY flag) all you will
have achieved is ensure that your client won't write to the file. You
will still be able to Oops.

  Trond

