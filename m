Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVAJIT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVAJIT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVAJIT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:19:56 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27914 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262140AbVAJITn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:19:43 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjan@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1105310650.11315.19.camel@lade.trondhjem.org>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 09:19:27 +0100
Message-Id: <1105345168.4171.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 17:44 -0500, Trond Myklebust wrote:
> su den 09.01.2005 Klokka 19:42 (+0000) skreiv Arjan van de Ven:
> > Hi,
> > 
> > the patch below makes flock_lock_file_wait static, because it is only used
> > (once) in fs/locks.c. Making it static allows gcc to generate better code
> > (partial or entirely inlining it, gcc 3.4 also optimizes the calling
> > convention for static functions which are guaranteed only local to the file)
> 
> Veto. That function is also there for those filesystems that need to
> mirror their locks in the VFS. I believe the GFS people are already
> using it (they implemented all this anyway), and sooner or later, NFS is
> going to have to do it too...

before
# size fs/locks.o
   text    data     bss     dec     hex filename
  14712      48       4   14764    39ac fs/locks.o

after (with static inline)
# size fs/locks.o
   text    data     bss     dec     hex filename
  14648      48       4   14700    396c fs/locks.o


is "sooner or later" and "maybe someone else uses it" worth making
everyone elses kernel bigger by 500 bytes of code ?


