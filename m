Return-Path: <linux-kernel-owner+w=401wt.eu-S1751915AbWLNK2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWLNK2b (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWLNK2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:28:31 -0500
Received: from www.osadl.org ([213.239.205.134]:51812 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751915AbWLNK2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:28:30 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 10:56:03 +0100
User-Agent: KMail/1.9.5
References: <20061213195226.GA6736@kroah.com> <Pine.LNX.4.64.0612131252300.5718@woody.osdl.org> <200612140949.43270.duncan.sands@math.u-psud.fr>
In-Reply-To: <200612140949.43270.duncan.sands@math.u-psud.fr>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141056.03538.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 09:49 schrieb Duncan Sands:
> > I'm really not convinced about the user-mode thing unless somebody can 
> > show me a good reason for it. Not just some "wouldn't it be nice" kind of 
> > thing. A real, honest-to-goodness reason that we actually _want_ to see 
> > used.
> 
> Qemu?  It would be nice if emulators could directly drive hardware:
> useful for reverse engineering windows drivers for example.

I really think there is a big misunderstanding in this whole discussion.
Userspace IO (UIO) was never intended to be a generic userspace 
interface to all kinds of hardware. I completely agree with Linus and all
others who expressed that opinion that a full-fledged kernel module is the,
let's say, most beautiful way of writing a driver. But it's not always the
best way. Let's look at a real world example:

A small German manufacturer produces high-end AD converter cards. He sells
100 pieces per year, only in Germany and only with Windows drivers. He would
now like to make his cards work with Linux. He has two driver programmers
with little experience in writing Linux kernel drivers. What do you tell him?
Write a large kernel module from scratch? Completely rewrite his code 
because it uses floating point arithmetics?

And even if they did that, do we really want it? Do we want to add large
kernel modules for each exotic card? With UIO, everything becomes much cleaner:

* They let somebody write the small kernel module they need to handle 
interrupts in a _clean_ way. This module can easily be checked and could
even be included in a mainline kernel.

* They do the rest in userspace, with all the libraries and tools they're
used to. That's what they _can_ do.

Note that this is a _technical_ reason. I'm not talking about all that
licensing possibilities that were discussed here.

UIO's intention is to allow manufacturers of industrial IO hardware to
support Linux without the need to hire half a dozen experienced kernel
developers. It makes their kernels more stable and easier to maintain.
We don't get flooded with requests to include large modules for exotic
hardware into the mainline kernel. 

The alternative is what we have at the moment: Manufacturers don't support
Linux at all, because it's too difficult to handle for them, or they do
it in a way that either violates our licence or leads to unstable 
customized kernels (or both).

So, your qemu suggestion is certainly interesting. But, really, we never
thought of such a general thing while we were working at that code.
I thought I had to make that clear. Reading this thread, one could get
the impression we wanted to start a revolution and handle all hardware
in userspace from now on. This is definetly wrong.

Hans

