Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTF0Xue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbTF0Xue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:50:34 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:15044 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S264944AbTF0Xuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:50:32 -0400
From: root@mauve.demon.co.uk
Message-Id: <200306280004.BAA23407@mauve.demon.co.uk>
Subject: Re: How to Avoid GPL Issue
To: gpc01532@hotmail.com (G. C.)
Date: Sat, 28 Jun 2003 01:03:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY8-F20kf6etlmIWMA00004812@hotmail.com> from "G. C." at Jun 27, 2003 07:04:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dear Sir or Madam,
> 
> We are trying to port a third party hardware driver into Linux kernel and 
> this third party vendor does not allow us to publish the source code. Is 
> there any approach that we can avoid publicizing the third party code while 
> porting to Linux? Do we need to write some shim layer code in Linux kernel 
> to interface the third party code? How can we do that? Is there any document 
> or samples?

The best way is to convince them to allow you to.
Otherwise.

The right way is to write a spec for the hardware, based on the code.
Now develop a GPL driver based on this spec.
This is the best way to do it, and will result in a driver distributed with
the kernel that can be maintained and used by anyone, likely on any 
architecture that the thing can be plugged into, even if you don't decide
to work on it any more, and the original vendor dies.

There are other ways.
Probably the wrong way is to simply compile this module, and distribute
the binary. 
This will result in you needing to create at the very least dozens of binaries
at each kernel upgrade, and your driver not working at all for many people
that you haven't compiled for.

If you can't afford the time/cost to go the GPL route, probably the least 
bad option is to move as much of the code as you can into a GPL'd interface
module that talks to a small binary stub.
Ideally the binary stub does not talk to the hardware, only to your 
interface module. 
This means that you need to compile only one stub per architecture, and
even in the face of dramatic kernel changes, as the part that talks to the
kernel (and hardware) is GPL, it can be fixed by anyone.
