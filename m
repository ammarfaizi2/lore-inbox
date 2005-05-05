Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVEEL7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVEEL7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVEEL7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:59:32 -0400
Received: from pat.uio.no ([129.240.130.16]:63908 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262059AbVEEL7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:59:05 -0400
Subject: Re: Crash when unmounting NFS/TCP with -f
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4279F2B3.4010409@ens-lyon.org>
References: <4268EEC9.8010305@ens-lyon.org> <426945CC.6040100@tmr.com>
	 <426DF305.7060109@ens-lyon.org>  <4279F2B3.4010409@ens-lyon.org>
Content-Type: multipart/mixed; boundary="=-+uYFWOz+ZWQ91JyNeRmE"
Date: Thu, 05 May 2005 07:58:45 -0400
Message-Id: <1115294325.10867.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.618, required 12,
	autolearn=disabled, AWL 1.33, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+uYFWOz+ZWQ91JyNeRmE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

to den 05.05.2005 Klokka 12:17 (+0200) skreiv Brice Goglin:

> Unable to handle kernel paging request at virtual address ffffff98
>  printing eip:
> e0aaa07a
> *pde = 00002067
> *pte = 00000000
> Oops: 0002 [#1]
> PREEMPT
> 
> Modules linked in: netconsole sd_mod usb_storage vfat fat loop isofs
> zlib_inflate nls_cp850 nls_iso8859_15 smbfs nfs lockd sunrpc i915 tun
> ipt_MASQUERADE iptable_nat ipt_state ip_conntrack iptable_filter
> ip_tables floppy uhci_hcd ehci_hcd dm_mod snd_intel8x0 snd_ac97_codec
> 
> CPU:    0
> EIP:    0060:[<e0aaa07a>]    Not tainted VLI
> EFLAGS: 00010297   (2.6.11=Macvin)
> EIP is at rpc_wake_up_status+0x6a/0x80 [sunrpc]
> eax: ffffff84   ebx: d0065888   ecx: 00000001   edx: c146e000
> esi: fffffffb   edi: d0065888   ebp: d0065800   esp: c146ef14
> ds: 007b   es: 007b   ss: 0068
> Process events/0 (pid: 3, threadinfo=c146e000 task=c1473020)
> Stack: c146ef44 d0065800 00000283 fffffffb e0aa710e d0065888 fffffffb
> 00120dcb c1473184 00000000 d0065904

Have you tried the attached patch? Andrew has already included it in the
-mm series.

Cheers,
  Trond

--=-+uYFWOz+ZWQ91JyNeRmE
Content-Disposition: inline
Content-Description: Vedlagt melding - [PATCH 2/2] RPC: kick off socket
	connect operations faster
Content-Type: message/rfc822

Return-Path: <cel@citi.umich.edu>
Received: from mail-imap5.uio.no ([unix socket]) by mail-imap5.uio.no
	(Cyrus v2.2.10) with LMTPA; Fri, 29 Apr 2005 21:46:09 +0200
X-Sieve: CMU Sieve 2.2
Delivery-date: Fri, 29 Apr 2005 21:46:09 +0200
Received: from mail-mx6.uio.no ([129.240.10.47]) by mail-imap5.uio.no with
	esmtp (Exim 4.43) id 1DRbRB-0001CZ-8Q for trond.myklebust@fys.uio.no; Fri,
	29 Apr 2005 21:46:09 +0200
Received: from climax.citi.umich.edu ([141.211.133.71]) by mail-mx6.uio.no
	with esmtps (TLSv1:AES256-SHA:256) (Exim 4.43) id 1DRbR7-0002vq-JL for
	trond.myklebust@fys.uio.no; Fri, 29 Apr 2005 21:46:05 +0200
Received: from climax.citi.umich.edu (localhost.localdomain [127.0.0.1]) by
	climax.citi.umich.edu (8.12.11/8.12.11) with ESMTP id j3TJk4V3009302 for
	<trond.myklebust@fys.uio.no>; Fri, 29 Apr 2005 15:46:04 -0400
Received: (from cel@localhost) by climax.citi.umich.edu
	(8.12.11/8.12.11/Submit) id j3TJk4qo009300 for trond.myklebust@fys.uio.no;
	Fri, 29 Apr 2005 15:46:04 -0400
Date: Fri, 29 Apr 2005 15:46:04 -0400
From: Chuck Lever <cel@citi.umich.edu>
Message-Id: <200504291946.j3TJk4qo009300@climax.citi.umich.edu>
To: trond.myklebust@fys.uio.no
Subject: [PATCH 2/2] RPC: kick off socket connect operations faster
X-MailScanner-Information: This message has been scanned for viruses/spam.
	Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.001, required 12,
	autolearn=disabled, AWL 0.00)
Mime-Version: 1.0
Content-Length: 1611
Status: O
X-UID: 367
X-Keywords: 
X-Evolution-Source: imap://trondmy@imap.trondhjem.org/
Content-Transfer-Encoding: 7bit

 Make the socket transport kick the event queue to start socket connects
 immediately.  This should improve responsiveness of applications that are
 sensitive to slow mount operations (like automounters).

 We are now also careful to cancel the connect worker before destroying
 the xprt.  This eliminates a race where xprt_destroy can finish before
 the connect worker is even allowed to run.

 Test-plan:
 Destructive testing (unplugging the network temporarily).  Connectathon
 with UDP and TCP.  Hard-code impossibly small connect timeout.

 Version: Fri, 29 Apr 2005 15:32:01 -0400
 
 Signed-off-by: Chuck Lever <cel@netapp.com>
---
 
 net/sunrpc/xprt.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)
 
 
diff -X /home/cel/src/linux/dont-diff -Naurp 10-rpc-reconnect/net/sunrpc/xprt.c 11-xprt-flush-connects/net/sunrpc/xprt.c
--- 10-rpc-reconnect/net/sunrpc/xprt.c	2005-04-29 15:18:47.677108000 -0400
+++ 11-xprt-flush-connects/net/sunrpc/xprt.c	2005-04-29 15:29:36.637250000 -0400
@@ -569,8 +569,11 @@ void xprt_connect(struct rpc_task *task)
 		if (xprt->sock != NULL)
 			schedule_delayed_work(&xprt->sock_connect,
 					RPC_REESTABLISH_TIMEOUT);
-		else
+		else {
 			schedule_work(&xprt->sock_connect);
+			if (!RPC_IS_ASYNC(task))
+				flush_scheduled_work();
+		}
 	}
 	return;
  out_write:
@@ -1666,6 +1669,10 @@ xprt_shutdown(struct rpc_xprt *xprt)
 	rpc_wake_up(&xprt->backlog);
 	wake_up(&xprt->cong_wait);
 	del_timer_sync(&xprt->timer);
+
+	/* synchronously wait for connect worker to finish */
+	cancel_delayed_work(&xprt->sock_connect);
+	flush_scheduled_work();
 }
 
 /*

--=-+uYFWOz+ZWQ91JyNeRmE--

