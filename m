Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFBCae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTFBCae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 22:30:34 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:16626 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261624AbTFBCad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 22:30:33 -0400
Message-Id: <200306020236.h522a8sG024853@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: alan@lxorguk.ukuu.org.uk, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Sun, 01 Jun 2003 18:42:54 PDT."
             <20030601.184254.71111683.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sun, 01 Jun 2003 22:34:24 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030601.184254.71111683.davem@redhat.com>,"David S. Miller" writes:
>1) Aparently the bug only needs to be worked around when
>   multiple cpus can access the card at the same time.
>   Therefore on uniprocessor the bug isn't relevant.

right.  which is why i optimized the HE_SPIN_LOCK away on
!CONFIG_SMP.  actually, its probably not a problem on certain
smp machines either.  i dont believe the i386 will reorder
read/writes from multiple cpus so in theory it would be safe to
do away with this lock on smp i386's.  the only arch that 
can reorder (and actually has posted read/writes) is the ia64/sn2.

>I personally don't think it's worth all the maintainence cost
>to special case all of this junk for uniprocessor.

well it wasnt much cost but i essentially decided this some
time ago and just defined HE_SPIN_LOCK to be spin_lock_irqsave.
the lock probably needs to be more fine-grained though in the
tasklet handler though.
