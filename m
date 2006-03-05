Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWCEXWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWCEXWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCEXWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:22:07 -0500
Received: from kanga.kvack.org ([66.96.29.28]:1956 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751150AbWCEXWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:22:06 -0500
Date: Sun, 5 Mar 2006 18:16:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Mateusz Berezecki <mateuszb@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: memory range R/W triggered breakpoints in kernel ?
Message-ID: <20060305231654.GB20768@kvack.org>
References: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 06:00:34PM +0100, Mateusz Berezecki wrote:
> I was thinking about writing some memory R/W access monitor. The only
> concern I'm
> having is whether it is doable, or are there any already existing and
> working solutions like
> that for Linux?

Most CPUs implement memory breakpoints of some sort, although they're 
usually limited to specific address instead of ranges.  See gdb's 
watch/awatch/rwatch commands.

> which was read/written from certain address. Afterwards the whole page 
> would be marked as non present again.

Use mprotect() and do it in userspace by catching SIGSEGV.  Doing it for 
the kernel is non-trivial and will hit upon arch specific issues like 
double fault handlers.  Given that the same sort of debugging can be done 
in userspace with UML and gdb, there isn't terribly much incentive to do 
the work to make something like this happen.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
