Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUGGWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUGGWDM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbUGGWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:03:12 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:61152 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S265531AbUGGWDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:03:10 -0400
Date: Thu, 8 Jul 2004 00:02:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707220258.GV28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet> <20040707182025.GJ28479@dualathlon.random> <20040707112953.0157383e.akpm@osdl.org> <20040707184202.GN28479@dualathlon.random> <1089233823.3956.80.camel@watt.suse.com> <20040707210608.GS28479@dualathlon.random> <20040707143015.03379d0f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707143015.03379d0f.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:30:15PM -0700, Andrew Morton wrote:
> And we cannot lock the page because, err, we need to run sync_page() for
> that.

exactly ;)

> But I cannot think of any callers of sync_page() who don't have a ref on
> the inode, so...

I'm thinking, does handle_write_error() holds a ref on the inode? that's
the VM and it finds the page without passing through the inode. I'm
afraid the VM isn't safe calling lock_page, or am I overlooking
something here?
