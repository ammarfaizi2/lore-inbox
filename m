Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTEMBs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEMBs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:48:59 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:39420 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263144AbTEMBsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:48:41 -0400
Date: Mon, 12 May 2003 19:00:36 -0700
From: Chris Wright <chris@wirex.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Chris Wright <chris@wirex.com>, Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix net/rxrpc/proc.c
Message-ID: <20030512190036.B20068@figure1.int.wirex.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Chris Wright <chris@wirex.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20030512173801.A20068@figure1.int.wirex.com> <1052790558.9169.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1052790558.9169.2.camel@rth.ninka.net>; from davem@redhat.com on Mon, May 12, 2003 at 06:49:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David S. Miller (davem@redhat.com) wrote:
> On Mon, 2003-05-12 at 17:38, Chris Wright wrote:
> > A recent change in 2.5.69-bk from Yoshfuji broke compilation of rxrpc
> > code.  It erroneously adds an owner field to the rxrpc_proc_peers_ops
> > seq_operations.  Fix below.
> 
> Why is it "erroneous"?  Just add the proper linux/module.h include
> to net/rxrpc/proc.c instead of spewing baseless claims.

Sorry, if I'm missing the obvious, but looking at my current bk tree I
see this:

include/linux/seq_file.h

struct seq_operations {
	void * (*start) (struct seq_file *m, loff_t *pos);
	void (*stop) (struct seq_file *m, void *v);
	void * (*next) (struct seq_file *m, void *v, loff_t *pos);
	int (*show) (struct seq_file *m, void *v);
};

It looks to me like there is a simple mistake of seq_operations !=
file_operations when adding .owner = THIS_MODULE to the file_operations.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
