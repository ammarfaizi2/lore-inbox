Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVAGQxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVAGQxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVAGQxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:53:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27841 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261507AbVAGQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:50:17 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
	than
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DE9D10.B33ED5E4@tv-sign.ru>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105110401.17166.346.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 15:45:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-07 at 14:30, Oleg Nesterov wrote:
> will block after writing PIPE_BUFFERS == 16 characters, no?
> And pipe_inode_info will use 64K to hold 16 bytes!
> 
> Is it ok?

That would break stuff, but holding the last page until it fills 4K
would work, or just basic sg coalescing when possible. The pipe
behaviour - particularly size and size of atomic writes is defined by
SuS and there are people who use pipes two ways between apps and use the
guarantees to avoid deadlocks

