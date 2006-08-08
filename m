Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWHHUDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWHHUDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 16:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWHHUDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 16:03:05 -0400
Received: from [198.99.130.12] ([198.99.130.12]:48081 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030282AbWHHUDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 16:03:04 -0400
Date: Tue, 8 Aug 2006 16:02:31 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] uml: fix proc-vs-interrupt context spinlock deadlock
Message-ID: <20060808200231.GA6463@ccure.user-mode-linux.org>
References: <20060807221400.GC5890@ccure.user-mode-linux.org> <20060808105905.10762.qmail@web25224.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808105905.10762.qmail@web25224.mail.ukl.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 12:59:05PM +0200, Paolo Giarrusso wrote:
> I could be wrong, but I trust that thanks to deep and good work by
> who designed locking in the network layer, this patch is correct. And
> indeed I addressed your issues below.

OK, but there will need to be comments explaining why it is OK that
this data only looks half-locked.

The locking, as it stands, looks consistent and conservative.
However, there are some places where critical sections are too big and
the locking should be narrowed.

> This is also true of char/block devices (you don't need to lock
> against write/read in open/close; UBD doesn't know that but I have
> unfinished patches for it), but there it's simpler: if userspace you
> call close while a read is executing, thanks to refcounting (sys_read
> does fget) the ->close (or ->release) is only called after the end of
> ->read.

In my current patchset, there is a per-queue lock which is mostly
managed by the block layer.

				Jeff
