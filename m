Return-Path: <linux-kernel-owner+w=401wt.eu-S932506AbWLNLGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWLNLGh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWLNLGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:06:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51597 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932506AbWLNLGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:06:37 -0500
Date: Thu, 14 Dec 2006 11:14:39 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Hua Zhong" <hzhong@gmail.com>
Cc: "'Martin J. Bligh'" <mbligh@mbligh.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, "'Greg KH'" <gregkh@suse.de>,
       "'Jonathan Corbet'" <corbet@lwn.net>, "'Andrew Morton'" <akpm@osdl.org>,
       "'Michael K. Edwards'" <medwards.linux@gmail.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-ID: <20061214111439.11bed930@localhost.localdomain>
In-Reply-To: <003801c71f45$45d722c0$6721100a@nuitysystems.com>
References: <4580E37F.8000305@mbligh.org>
	<003801c71f45$45d722c0$6721100a@nuitysystems.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 22:01:15 -0800
"Hua Zhong" <hzhong@gmail.com> wrote:

> > I think allowing binary hardware drivers in userspace hurts 
> > our ability to leverage companies to release hardware specs. 
> 
> If filesystems can be in user space, why can't drivers be in user space? On what *technical* ground?

The FUSE file system interface provides a clean disciplined interface
which allows an fs to live in user space. The uio layer (if its ever
fixed and cleaned up) provides some basic hooks that allow a user space
program to arbitarily control hardware and make a nasty undebuggable mess.

uio also doesn't handle hotplug, pci and other "small" matters.

Now if you wanted to make uio useful at minimum you would need

-  PCI support
-  The ability to mark sets of I/O addresses for the card as
"unmappable", "read only", "read-write", "any read/root write", "root
read/write"
-  A proper IRQ handler
-  A DMA interface
-  The ability to describe sharing rules

Which actually is a description of the core of the DRM layer.
