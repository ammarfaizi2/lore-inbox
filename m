Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWDXUfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWDXUfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWDXUfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:35:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35493 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751245AbWDXUfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:35:33 -0400
Subject: Re: Compiling C++ modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 21:45:46 +0100
Message-Id: <1145911546.1635.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 13:16 -0600, Gary Poppitz wrote:
> I have the task of porting an existing file system to Linux. This  
> code is in C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.

We tried various things involving C++ along the line in kernel history
and there are so many problems it throws up the kernel took the view
that it would not use C++ in kernel. Instead object orientation is
performed more explicitly in C. This has many advantages including the
exposure of inefficient code explicitly and the avoidance of exceptions
and the assumption memory allocations just don't fail that much C++
makes without exceptions being used. It might be possible to move to a
strict C++ subset in the style of Apple but there isn't much interest in
this.

There are other problems too, notably the binary ABI between the C and C
++ compiler might not match for all cases (in particular there are
corner cases with zero sized objects and C++).


> I would be most willing to point out the areas that need adjustment  
> and supply patch files to be reviewed.
> 
> What would be the best procedure to accomplish this?

If you want to maintain your own out of tree file system then probably
you want to use #defines to wrap the kernel tree. Most stuff will
probably work ok if you do this although you'll want some C to C++
wrappers to interface to the kernel obviously.

If you want to submit the file system to the kernel source then it needs
shifting from C++ to C but of course there are people in the community
who can help you. As the kernel C is very object based that isn't
usually too much of a problem. Most objects in the kernel (inodes, files
etc) are of the form

	struct thing {
		struct thing_ops *ops; /* methods */
		blah
	}

and that style fits much C++ code being ported over.

There are a few anti C++ bigots around too, but the kernel choice of C
was based both on rational choices and experimentation early on with the
C++ compiler.

Alan

