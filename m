Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTEWE6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 00:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTEWE6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 00:58:39 -0400
Received: from pat.uio.no ([129.240.130.16]:4590 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263632AbTEWE6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 00:58:38 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
	<Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
	<20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
	<20030522194211.4191e473.akpm@digeo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 23 May 2003 07:11:33 +0200
In-Reply-To: <20030522194211.4191e473.akpm@digeo.com>
Message-ID: <shsvfw29ri2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@digeo.com> writes:

     > I assume every foo_truncate() is doing

    inode-> i_mtime = inode->i_ctime = CURRENT_TIME;
     >         mark_inode_dirty(inode);

     > and as Andries says, we can probably pull all that up to the
     > VFS level.

No. Please do not assume that the above is equivalent to calling
notify_change() with ATTR_MTIME|ATTR_CTIME.

NFS tends to leave the above to the server side, since the clocks may
be desynchronized between client and server.

As far as NFS is concerned, we should only be setting ATTR_*TIME if/when
the *user* specifies it through a utimes() call or something like that.

Cheers,
  Trond
