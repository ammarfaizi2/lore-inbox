Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUGGSbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUGGSbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUGGSbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:31:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:22752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265290AbUGGSbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:31:00 -0400
Date: Wed, 7 Jul 2004 11:29:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo.tosatti@cyclades.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-Id: <20040707112953.0157383e.akpm@osdl.org>
In-Reply-To: <20040707182025.GJ28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet>
	<20040707182025.GJ28479@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> however the smp_mb() isn't needed in sync_page, simply because it's
>  perfectly ok if we start running sync_page before reading pagelocked.
>  All we care about is to run sync_page _before_ io_schedule() and that we
>  read PageLocked _after_ prepare_to_wait_exclusive.
> 
>  So the locking in between PageLocked and sync_page is _absolutely_
>  worthless and the smp_mb() can go away.

IIRC, Chris added that barrier (and several similar) for the reads in
page_mapping().
