Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319442AbSH3GVV>; Fri, 30 Aug 2002 02:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319444AbSH3GVV>; Fri, 30 Aug 2002 02:21:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45830 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319442AbSH3GVU>;
	Fri, 30 Aug 2002 02:21:20 -0400
Message-ID: <3D6F12A4.285DF44@zip.com.au>
Date: Thu, 29 Aug 2002 23:37:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
Subject: Re: page-flags.h pollution?
References: <200208300556.g7U5up3c025064@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> In the 2.5.3x kernel, what's the point of defining pte_chain_lock()
> and pte_chain_unlock() in page-flags.h?  These two routines make it
> impossible to include page-flags.h on it's own, because they require
> "struct page" to be defined (and a forward declaration isn't
> sufficient either).  This can introduce rather annoying circular
> include-file dependencies.

It's a wart.  The now-abandoned hashed spinlocking patch moves
them into <linux/rmap-locking.h>.   We can do that anyway - only
two files need it.

Or maybe just put them in asm-generic/rmap.h.   I'll fix it up.
