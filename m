Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423018AbWJZKgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423018AbWJZKgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423141AbWJZKgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:36:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32689 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423018AbWJZKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:36:46 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: proski@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061025205923.828c620d.akpm@osdl.org>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <20061025205923.828c620d.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 11:39:59 +0100
Message-Id: <1161859199.12781.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 20:59 -0700, ysgrifennodd Andrew Morton:
> May be so.  But this patch was supposed to print a helpful taint message to
> draw our attention to the fact that ndis-wrapper was in use.  The patch was
> not intended to cause gpl'ed modules to stop loading 

The stopping loading is purely because it now uses _GPLONLY symbols,
which is fine until the user wants to load a windows driver except for
the old CIPE driver. Some assumptions broke somewhere along the way and
the chain of events that was never forseen unfolded.

> Now, if we do want to disallow gpl module loading after ndis-wrapper has
> been used then fine

The problem is we do the dynamic link at module load time. We would have
to unlink the module if it tried to taint itself, which is clearly not
what the end user needs to suffer. Having the taint function actually
taint and printk + return a "Linked gplonly you can't" error seems the
better solution.

Really ndiswrapper shouldn't be using _GPLONLY symbols, that would
actually make it useful to the binary driver afflicted again and more
likely to be legal.

