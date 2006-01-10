Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWAJAoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWAJAoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWAJAoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:44:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751800AbWAJAo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:44:29 -0500
Date: Mon, 9 Jan 2006 16:44:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
Message-Id: <20060109164410.3304a0f6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
References: <20060109203711.GA25023@kroah.com>
	<Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Mon, 9 Jan 2006, Greg KH wrote:
> >
> > Here are some PCI patches against your latest git tree.  They have all
> > been in the -mm tree for a while with no problems.  I've pulled out all
> > of the offending patches that people objected to, or ones that crashed
> > older machines from the last series I sent you.
> 
> Before I pull this, I'd like to get some confirmation that some of the 
> other problems that seem to be PCI-related in the -mm tree are also 
> understood, or at least known to be part of the stuff that you're _not_ 
> sending me..

It's really hard to keep track of all this, so it's likely that some things
will still sneak through.

- Reuben Farrelly's oops in make_class_name().  Could be libata, or scsi
  or driver core.

- A few problems with ehci.  For example Grant Coady went oops loading
  the module.  Probably USB, maybe solved now, but there are
  interactions...

- gregkh-pci-x86-pci-domain-support-the-meat.patch is a problem, but
  wasn't in this tree.

> [ There's at least a pci_call_probe() NULL ptr dereference report by 
>   Martin Bligh, I think Andrew has a few others he's tracked.. ]

Yes, Martin is reporting failures on a few machines.  Hopefully he's
working out whether gregkh-pci-x86-pci-domain-support-the-meat.patch was
the culprit here.  If so, I'd say we're good to go.  If that's _not_ the
source then we just don't know where the failure is coming from.

All very vague, sorry.

