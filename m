Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWIMEyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWIMEyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWIMEyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:54:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:48799 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751561AbWIMEyh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:54:37 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 13 Sep 2006 14:54:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <17671.36613.134163.171162@cse.unsw.edu.au>
Cc: Magnus =?ISO-8859-1?B?TeTkdHTk?= <novell@kiruna.se>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm1
In-Reply-To: message from Andrew Morton on Saturday September 9
References: <200609091445.32744.novell@kiruna.se>
	<20060909112724.a214197b.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday September 9, akpm@osdl.org wrote:
> On Sat, 9 Sep 2006 14:45:32 +0200
> Magnus M‰‰tt‰ <novell@kiruna.se> wrote:
> > [15164.017991] RPC request reserved 9136 but used 9268
> > [15164.037431] RPC request reserved 9136 but used 9268
> > [15164.052988] RPC request reserved 9136 but used 9268
> > 

Don't know what is causing this yet....

> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00210212   (2.6.18-rc6-mm1 #1)
> > eax: 00000000   ebx: e5299000   ecx: 00000000   edx: e8843620
..
> >  [<c02784ba>] nfsd+0x18a/0x2b0
> >  [<c0103fb7>] kernel_thread_helper+0x7/0x10
> > Code: 89 45 e8 8b 52 28 83 c6 70 89 55 e4 8b 40 04 83 f8 17 0f 86 6d 
> > 04 00 00 8b 5d 08 8b 83 9c 04 00 00 c7 83 a0 04 00 00 01 00 00 00 
> > <8b> 00 89 04 24 e8 06 d4 ca ff c7 46 04 00 00 00 00 89 c1 89 43
> > 
> > 
> > >>EIP; c04ad300 <svc_process+40/6a0>   <=====

But this is probably fixed by the following patch.
Can you confirm?


thanks,
NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |    1 +
 1 file changed, 1 insertion(+)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-09-13 14:48:05.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-09-13 14:48:14.000000000 +1000
@@ -1709,6 +1709,7 @@ static int svc_deferred_recv(struct svc_
 	rqstp->rq_prot        = dr->prot;
 	rqstp->rq_addr        = dr->addr;
 	rqstp->rq_daddr       = dr->daddr;
+	rqstp->rq_respages    = rqstp->rq_pages;
 	return dr->argslen<<2;
 }
 
