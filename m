Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbTIQWia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTIQWi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:38:29 -0400
Received: from pat.uio.no ([129.240.130.16]:2503 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262870AbTIQWi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:38:28 -0400
To: Paul N <pauln@psc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 NFS / EJUKEBOX problem
References: <3F68D055.3090701@psc.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Sep 2003 18:38:25 -0400
In-Reply-To: <3F68D055.3090701@psc.edu>
Message-ID: <shsekyfniqm.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul N <Paul> writes:

     > Hi, I'm seeing a weird problem with NFSv3's EJUKEBOX when
     > mounting a irix machine running DMF (software for managing
     > offline/tape copies of files).  When an NFS read request is
     > made for an 'offline' file it causes other write requests to
     > stall until the 'offline' file is unmigrated to

     > disk and the read can resume. From looking at tcpdump it seems
     > that the write requests proceed until

     > an EJUKEBOX msg from the read is returned from the server.  At
     > that point all write requests are stuck behind the jukeboxed
     > read. Could someone please give me some information on this?

The writes are probably waiting in 'nfs_try_to_free_pages()' because
you are hitting the hard limit on outstanding read/write requests.
The NFS code is not allowed to allocate more than MAX_REQUEST_HARD
requests per mountpoint at any time since there is otherwise no way
for the VM to notify us in case of resource starvation.

Cheers,
  Trond
