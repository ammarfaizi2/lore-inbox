Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbTGNRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270698AbTGNRA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:00:57 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62569 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270714AbTGNRAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:00:34 -0400
Date: Mon, 14 Jul 2003 13:14:01 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714131400.N15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com> <20030715025252.17ec8d6f.sfr@canb.auug.org.au> <20030714130024.M15481@devserv.devel.redhat.com> <20030715031123.5c8e0c96.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030715031123.5c8e0c96.sfr@canb.auug.org.au>; from sfr@canb.auug.org.au on Tue, Jul 15, 2003 at 03:11:23AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 03:11:23AM +1000, Stephen Rothwell wrote:
> > This is not correct for the merged header.
> > It needs to be:
> > #ifdef __s390x__
> > #define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
> > #endif
> 
> OK, I can see that (although is __s390x__ defined when building a
> 32 (31?) bit kernel on a 64bit s390?).

__s390x__ is defined when doing 64-bit compile targetted to s390.
Ie. gcc -m64 defines it, gcc -m31 does not.

> > Furthermore, there needs to be a pad inserted fo arch/s390x/kernel/signal.c
>                                                         ^^^^^
> s390?  (there is no arch/s390x in 2.6.0-test1)

Then that pad needs to be #ifdef __s390x__ as well.
> 
> > (rt_sigframe right after info member) to keep binary compatibility.

	Jakub
