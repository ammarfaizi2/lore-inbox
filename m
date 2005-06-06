Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVFGABn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVFGABn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFFX5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:57:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56209 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261778AbVFFXwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:52:34 -0400
Date: Tue, 7 Jun 2005 00:53:21 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/5] UML - Clean up tt mode remapping of UML binary
Message-ID: <20050606235321.GJ29811@parcelfarce.linux.theplanet.co.uk>
References: <200506062008.j56K89YA008957@ccure.user-mode-linux.org> <200506070105.20422.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506070105.20422.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:05:19AM +0200, Blaisorblade wrote:
> On Monday 06 June 2005 22:08, Jeff Dike wrote:
> > From Al Viro - this turns the tt mode remapping of the binary into arch
> > code.
> NACK at all, definitely, don't apply this one please. This patch:
> 
> 1) On i386 does not fix the problem it was supposed to fix when I originately 
> sent the first version (i.e. avoiding to create a .thread_private section to 
> allow linking against NPTL glibc). It's done on x86_64 and forgot on i386.

True.  i386 still assumes non-NPTL (as it is on the box I'm working on -
such setups *do* exist).

> 2) Splitting the linker script for subarchs is definitely not needed.

Per-subarch - perhaps not.  Per-glibc-type - definitely needed.

> 3) This removes the fix (done through objcopy -G switcheroo) to a link time 
> conflict happening on some weird glibc combinations.

*What* link-time conflict?  We don't link libc into switcheroo anymore.
