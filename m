Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUDHP3C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDHP3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:29:02 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:63429 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261993AbUDHP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:28:58 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <20040408151415.GB31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain>
	<1081435237.1885.144.camel@mulgrave> 
	<20040408151415.GB31667@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 10:28:44 -0500
Message-Id: <1081438124.2105.207.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 10:14, Andrea Arcangeli wrote:
> you'd need to take a semaphore there to be safe, so it's basically
> unfixable since you can't sleep or just trylock.

That's a bit of an unhelpful suggestion.

flush_dcache_page() exists to support coherency problems with virtual
aliasing and a feature of that is that you have to flush every
inequivalent user address which might be cached, hence the need for list
traversal.

Exactly why wouldn't a simple spinlock to protect page->mapping work?  I
know we don't want to bloat struct page, but such a thing could go in
struct address_space?

James


