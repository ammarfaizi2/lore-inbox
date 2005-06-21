Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFULut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFULut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVFULtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:22694 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261194AbVFUL1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:27:47 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, telendiz@eircom.net
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement  in /fs/open.c
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain.suse.lists.linux.kernel>
	<42B70E62.5070704@pobox.com.suse.lists.linux.kernel>
	<Pine.LNX.4.62.0506201154300.2245@graphe.net.suse.lists.linux.kernel>
	<20050620133800.0dac1d97.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2005 13:27:45 +0200
In-Reply-To: <20050620133800.0dac1d97.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p738y14c5la.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> The old trick to make the error-handling code out-of-line shouldn't be
> needed nowadays - IS_ERR uses unlikely(), which is supposed to handle that
> stuff.

In fact it doesn't even work anymore with -freorder-blocks (which is
default on i386). Without unlikely gcc 3.3/3.4 will happily move the out of
line block back. I was told that newer gcc gives a bit more value
to user gotos, but it doesn't help on the older compilers.

-Andi (who also thinks there are too many gotos in the kernel and 
many should be cleaned up) 
