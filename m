Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280718AbRKSVSH>; Mon, 19 Nov 2001 16:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKSVRr>; Mon, 19 Nov 2001 16:17:47 -0500
Received: from pat.uio.no ([129.240.130.16]:53477 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S280714AbRKSVRk>;
	Mon, 19 Nov 2001 16:17:40 -0500
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <15353.23941.858943.218040@charged.uio.no>
	<200111191952.WAA21731@ms2.inr.ac.ru>
	<15353.28112.350734.11894@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 19 Nov 2001 22:17:33 +0100
In-Reply-To: <15353.28112.350734.11894@charged.uio.no>
Message-ID: <shsn11i31g2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > I haven't done anything about this because IMHO it makes more
     > sense to have the QDIO driver drop their special spinlock when
     > calling external functions such as dev_kfree_skb_any() rather
     > than to force the RPC layer to use the spin_lock_irqsave().

I forgot to add: The socket fasync lists use spinlocking in the same
was as RPC does, with sock_fasync() setting
write_lock_bh(&sk->callback_lock), and sock_def_write_space()
doing read_lock(&sk->callback_lock).

So that would deadlock with the QDIO driver in the exact same manner
as the RPC stuff (albeit probably a lot less frequently).

Cheers,
   Trond
