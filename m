Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTFFOx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTFFOx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:53:57 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:22524 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261825AbTFFOx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:53:56 -0400
Message-Id: <200306061507.h56F7PsG026811@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 04:04:10 PDT."
             <20030606.040410.54190551.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 11:05:37 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606.040410.54190551.davem@redhat.com>,"David S. Miller" writes:
>Basically it protects all networking administrative actions, add an
>address for a device, up a device, down a device, add a route, attach
>a packet scheduler to dev, etc. etc.

so should i hold rtnl across add/remove atm addresses on atm dev's?
(but iw ouldnt hold rtnl across people just reading the list of
atm addresses right?)

>Hmmm, this is not how RTNL works on netdevs.  The SMP lock is held
>around all walking, and at the very precise moment where we are
>doing the actual device unlink from dev_base.  rtnl is acquired at
>top-level when we will change something.

>This is very different from how you are using the lock+rtnl scheme
>for your ATM stuff.

ok, i was thinking i could use rtnl to protect readers.  this makes the
connect(dev = ANY) rather icky.  some of the abuse by me in other places
might be moot in the future.  i am planning (or have done) to move all
the vcc's onto a global list (ala many of the other protocol stacks).
this makes the code for proc (and others) much cleaner since you just grab
a read lock on the global vcc sklist instead of locking and interating
each atm device.  further, this will let atm interrupt handlers block
a race with vcc close/removal.  is this a bad plan?
