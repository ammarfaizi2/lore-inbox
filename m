Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTKRQ0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 11:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTKRQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 11:26:45 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:16135 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263728AbTKRQ0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 11:26:31 -0500
Subject: Re: lib.a causing modules not to load
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031117060542.088D32C0B1@lists.samba.org>
References: <20031117060542.088D32C0B1@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Nov 2003 10:25:16 -0600
Message-Id: <1069172719.1835.30.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-16 at 20:47, Rusty Russell wrote:
> I think lib.a should be linked as is if !CONFIG_MODULES, and done as a
> ..o if CONFIG_MODULES.  Other alternatives are possible, but make it
> tricky if someone adds a module later which wants something in lib.a.

I tried this and it is getting to be a whole nasty mess can of worms:

You can't link the lib objects all in, because they can be overridden by
the arch dependent lib.a (we rely on link order to permit this).  For
instance on x86, dump_stack and bust_spinlocks give duplicate symbols.

If we have to add processing logic to work out what symbols are in the
arch lib.a, we might as well go the whole hog and try to work out what
is missing from the kernel and compile that alone as a module.

James




