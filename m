Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278693AbRJSXgj>; Fri, 19 Oct 2001 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278695AbRJSXgU>; Fri, 19 Oct 2001 19:36:20 -0400
Received: from smtp-rt-6.wanadoo.fr ([193.252.19.160]:27044 "EHLO
	caroubier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278694AbRJSXgN>; Fri, 19 Oct 2001 19:36:13 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Sat, 20 Oct 2001 01:33:22 +0200
Message-Id: <20011019233322.26154@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading about the suspend to disk issue, and thinking about
some of pmac needs, I tend to stil think we have overlooked
that ordering issue.

We should probably add a couple of list_heads to define a second
tree in parallell to the device-tree, which is the power tree.
A device is by default inserted in both tree as a child of it's bus
controller.
But the arch must be able to move it elsewhere. I beleive we have
a way around the VM related ordering issues, but we do have other
kind of ordering constraints that have to be dealt with when
we start broadcasting the callbacks. 

Also, I think you didn't state that io_bus is a superset of device.
In fact, it's just a device that has childs, and this should
probably be more generically viewed in struct device itself.

Any device should be able to have childs, so we really have 2
interleaved trees of devices, the bus tree and the power tree.
In fact, to be complete, we could even define the interrupt tree
with one more set of links as it's really not related to the bus
tree on many archs/machines, and having a tree definition is really
useful when you deal with cascaded controllers.

What do you think ?

Ben.


