Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136063AbRAGRYE>; Sun, 7 Jan 2001 12:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135961AbRAGRXy>; Sun, 7 Jan 2001 12:23:54 -0500
Received: from mons.uio.no ([129.240.130.14]:14547 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S135371AbRAGRXm>;
	Sun, 7 Jan 2001 12:23:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14936.42515.988953.602296@charged.uio.no>
Date: Sun, 7 Jan 2001 18:23:31 +0100 (CET)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Even slower NFS mounting with 2.4.0
In-Reply-To: <E14FJIN-0002xW-00@the-village.bc.nu>
In-Reply-To: <shs1yufxqvq.fsf@charged.uio.no>
	<E14FJIN-0002xW-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

    >> > This is caused by 2.3/2.4 changes in the network code error
    >> > reporting of unreachables with UDP I suspect. It looks like
    >> > the NFS code hasn't yet caught up with the error notification
    >> > stuff
    >>
    >> No. It was the fact that he was forgetting to start the
    >> portmapper before mounting an NFS partition with locking
    >> enabled.

     > Its both. If you support the error notification then you see
     > the PORT UNREACH and you abandon early even if the user makes
     > that error

Hmm... How should we respond to that sort of thing? In principle the
NFS layer supposes that if we have a hard mount, then unreachable
ports etc are a temporary problem, and we should wait them out.  (In
fact, I've made an RPC 'ping' routine that improves on that behaviour
but which unfortunately didn't make it into 2.4.0.)

If we want to check that the port is reachable at the moment when we
mount, I think we should concentrate on making 'mount' more
intelligent. Perhaps have it RPC-ping the various ports (including the
local portmapper when we specify locking)?

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
