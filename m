Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270701AbTGNSVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270708AbTGNSVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:21:24 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58311 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270701AbTGNSVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:21:21 -0400
Date: Mon, 14 Jul 2003 14:35:59 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714143558.P15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <OF8354A4F2.09CC83D0-ONC1256D63.0064A671@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF8354A4F2.09CC83D0-ONC1256D63.0064A671@de.ibm.com>; from Ulrich.Weigand@de.ibm.com on Mon, Jul 14, 2003 at 08:31:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 08:31:34PM +0200, Ulrich Weigand wrote:
> The MD_FALLBACK_FRAME_STATE_FOR macro does not use sizeof(siginfo_t)
> at all, but hardcodes 128.  (This has always been the case, and was
> done to avoid the need to include signal.h.)  This is still broken
> with the current kernel behaviour, though.
> 
> It is strange that I didn't notice the problem earlier; apparently
> most of the places where unwinding through signal frames is required
> use non-RT frames ...

But it is crucial for NPTL pthread_cancel.

> >This though means that the kernel siginfo_t change cannot be done
> >just in asm-*/siginfo.h headers - at least places where siginfo_t
> >is present within some structures ever visible to userland a dummy
> >8 byte pad needs to be inserted.
> 
> As userspace expects a size of 128 bytes, and with the change
> the size now *is* 128 bytes, why would a pad be required?

As I tried to write, we either can have all GCCs
which will work properly only with new kernels (no pad added),
or we can have new GCCs working with all kernels (if pad is added).
Your choice...

	Jakub
