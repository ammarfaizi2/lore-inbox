Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTFDPx0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTFDPx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:53:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263535AbTFDPxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:53:24 -0400
Date: Wed, 4 Jun 2003 09:08:08 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 add_disk(disk) re-registering disk->queue->elevator.kobj
 (bug?!)
In-Reply-To: <20030604005625.GF6754@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0306040834120.13077-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is utterly ridiculous.  I realize that sysfs is fashionable, but
> it should reflect the existing logics, not the other way round.

I completely agree. When converting a subsystem to use the kobject model,
there are essentially three paths to choose:

- Convert the subsystem to use the kobject semantics 
- Convert the kobject model to tolerate the semantics of the subsystem 
- Something else

The first is very attractive because it requires little effort to get an
appealing layout in the filesystem and export some attributes for a class
of objects. It's worked on some cases so far, but it's also proven to not
work for all classes of objects, _especially_ when they start interacting
with each other.

Converting the kobject model to tolerate other semantics is fine, and I'm
happy to see it happen. However, it must not make special cases for random
subsystems. Which is where the 'something else' comes in.

The object lifetime and interaction rules must be understood for each
object that is converted to use kobjects. Once they are, as well as their
violations of the current kobject semantics, we can work to improve both.


The fact that kobjects make it easy to shoot ourselves in the head is bad.  
But, the fact that they make long-existing bugs easier to trigger and
force people to deal with them and fix them is a good thing, in the long
run. There's a lot of code out there, much of which not a lot of people
understand. If we're forced to audit it, understand it, and fix it, then
we all win in the end.

HOWEVER, the current development model does not jive very well with the
fact that we're quickly approaching 2.6. The temporary instability
introduced by a kobject transition does not help the immediate cause. If
conversions are going to happen in the near future, they need to be
completely understood, well-thought out, and stable.

I realize that it helps to do it gradually, and not everyone is as
talented as Al in doing atomic large-scope gradual sets of patches. Also,
that many people have the time/energy to continue working on conversions
and kobject infrastructure. So, as a harbor for this continued work, and a
pre-cursor to 2.7, I've set up a tree at
bk://ldm.bkbits.net/linux-2.5-sysfs People are welcome to send me patches,
which I'll keep there and push forward once they become stable and/or
necessary.



	-pat

