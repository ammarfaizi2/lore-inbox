Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTGAKnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTGAKnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:43:46 -0400
Received: from pat.uio.no ([129.240.130.16]:5329 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262093AbTGAKnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:43:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16129.26928.805604.57986@charged.uio.no>
Date: Tue, 1 Jul 2003 12:57:52 +0200
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] NFS client fixes for 2.4.22
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, please do a

	bk pull http://nfsclient.bkbits.net/linux-2.4

This will update the following files:

 fs/lockd/clntproc.c         |    2 
 fs/lockd/host.c             |    9 -
 fs/lockd/mon.c              |    1 
 fs/lockd/svc4proc.c         |   21 ++
 fs/lockd/svclock.c          |    2 
 fs/lockd/svcproc.c          |   19 ++
 fs/nfs/nfs3proc.c           |   11 -
 fs/nfs/write.c              |   11 +
 include/linux/lockd/lockd.h |    1 
 include/linux/sunrpc/xprt.h |   23 ++
 net/sunrpc/clnt.c           |  182 ++++++++++------------
 net/sunrpc/xdr.c            |  221 +++++++++++++++++++++++++-
 net/sunrpc/xprt.c           |  364 ++++++++++++++++++++++++--------------------
 13 files changed, 575 insertions(+), 292 deletions(-)

through these ChangeSets:

<Richard.Curnow@superh.com> (03/07/01 1.1032)
   Ensure that the 'unlink' XDR structures are correctly aligned on 64-bit
   architectures.

<trond.myklebust@fys.uio.no> (03/06/27 1.1024)
   Replace buggy version of xdr_shift_buf() with the version from 2.5.x.
   This has the added bonus that we also get rid of the need for
   doing kmap() of multiple pages at the same time.

<trond.myklebust@fys.uio.no> (03/06/27 1.1023)
   Ensure that the lockd clients always use one of the reserved ports.

<trond.myklebust@fys.uio.no> (03/06/27 1.1022)
   Fix a TCP client corruption problem affecting resent requests.

<trond.myklebust@fys.uio.no> (03/06/27 1.1021)
   Ensure that if we need to reconnect the socket, we also resend
   the entire message.
   
   Assorted TCP reconnection fixes.
   
   Temporarily raise the necessary CAP_NET_BIND_SERVICE capability
   if we need to bind the socket to a reserved port during a TCP
   reconnection. Check for CAP_NET_BIND_SERVICE at mount time.

<trond.myklebust@fys.uio.no> (03/06/27 1.1020)
   Don't use an RPC child process when reconnecting to a TCP server.
   This is more efficient, and also fixes an existing deadlock
   situation in which the child could be waiting for an xprt_write_lock
   that was being held by the parent.

<trond.myklebust@fys.uio.no> (03/06/27 1.1019)
   Fix a race: Ensure that requests retry if the remote server
   disconnects us while we're inside xprt_transmit().

<trond.myklebust@fys.uio.no> (03/06/27 1.1018)
   Add standard spinlocks to protect the socket from being released by one
   CPU while the other is in a soft interrupt.

<trond.myklebust@fys.uio.no> (03/06/27 1.1017)
   A patch to ensures that blocks which are not going to time out
   are placed last on the nlm_block list (problem reported by
   Olaf Kirch).

<trond.myklebust@fys.uio.no> (03/06/27 1.1016)
   A patch by Patrice Dumas to add a check in order to ensure that we
   really were requesting a blocking lock when we get a reply from the
   server asking us to block.

<trond.myklebust@fys.uio.no> (03/06/27 1.1015)
   A patch by Patrice Dumas to implement nlmsvc_proc_granted_res.
   When a server receives that callback it deallocates the corresponding
   blocked lock, using the nlmsvc_grant_reply function.

<trond.myklebust@fys.uio.no> (03/06/27 1.1014)
   Another patch by Chuck Lever that ensures that the PG_uptodate bit gets
   set when the entire page gets written by nfs_writepage_sync()

<trond.myklebust@fys.uio.no> (03/06/27 1.1013)
   A patch by Chuck Lever with further cleanups of the RPC socket
   slot allocation code.

<trond.myklebust@fys.uio.no> (03/06/27 1.1012)
   A patch by Chuck Lever that cleans up the RPC socket
   slot allocation code.

