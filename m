Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbTFBBbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbTFBBbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:31:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28610 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264779AbTFBBbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:31:24 -0400
Date: Sun, 01 Jun 2003 18:42:54 -0700 (PDT)
Message-Id: <20030601.184254.71111683.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: alan@lxorguk.ukuu.org.uk, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306012300.h51N0AsG023776@ginger.cmf.nrl.navy.mil>
References: <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk>
	<200306012300.h51N0AsG023776@ginger.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Sun, 01 Jun 2003 18:58:26 -0400

   In message <1054497613.5863.4.camel@dhcp22.swansea.linux.org.uk>,Alan Cox writes:
   >Then why are you using spin_lock_irqsave ?
   
   meaning just use spin_lock() or what?
   
Alan/Chas, there are two different issues here:

1) Aparently the bug only needs to be worked around when
   multiple cpus can access the card at the same time.

   Therefore on uniprocessor the bug isn't relevant.

2) Therefore, the lock needs to protect register accesses
   from all contexts.  Therefore he needs an IRQ protecting
   lock.

Therefore it isn't legal for him to use a non-IRQ protecting
spinlock.

I personally don't think it's worth all the maintainence cost
to special case all of this junk for uniprocessor.
