Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292503AbSCFU0x>; Wed, 6 Mar 2002 15:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCFU0n>; Wed, 6 Mar 2002 15:26:43 -0500
Received: from pat.uio.no ([129.240.130.16]:1711 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S292503AbSCFU0d>;
	Wed, 6 Mar 2002 15:26:33 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Patch to pull NFS server address off root_server_path
In-Reply-To: <E16iSfH-0007W9-00@wagner.rustcorp.com.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Mar 2002 21:26:14 +0100
In-Reply-To: <E16iSfH-0007W9-00@wagner.rustcorp.com.au>
Message-ID: <shsk7sp4f4p.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Rusty Russell <rusty@rustcorp.com.au> writes:

     > This patch was submitted to the trivial patch daemon.  Looks OK
     > to me, Trond?

     > --- linux.orig/net/ipv4/ipconfig.c Tue Feb 26 07:14:51 2002
     > +++ linux/net/ipv4/ipconfig.c Wed Mar 6 14:01:10 2002
     > @@ -1197,6 +1197,16 @@
     >  		ic_dev = ic_first_dev->dev;
     >  	}
 
     > +#ifdef CONFIG_ROOT_NFS
     > + {
     > + extern void __init root_nfs_parse_addr(char *name, u32
     >  		*addr);
     > + u32 addr = INADDR_NONE;
     > + root_nfs_parse_addr(root_server_path, &addr);
     > + if (root_server_addr == INADDR_NONE)
     > + root_server_addr = addr;
     > + }
     > +#endif +

Erm... Is this __init declaration here correct?

Wouldn't it really be better to move root_nfs_parse_addr() into the
ipconfig code? Since, CONFIG_ROOT_NFS depends on CONFIG_IP_PNP being
set, you could also get rid of your #ifdef above...

Cheers,
  Trond
