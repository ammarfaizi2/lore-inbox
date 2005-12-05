Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964877AbVLEXld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964877AbVLEXld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbVLEXld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:41:33 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:24535 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964877AbVLEXlc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:41:32 -0500
Date: Tue, 6 Dec 2005 00:45:00 +0100
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051205234500.GA19164@aitel.hist.no>
References: <20051205214545.41191.qmail@web50212.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205214545.41191.qmail@web50212.mail.yahoo.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 01:45:44PM -0800, Alex Davis wrote:
> The issues with wireless drivers, as far as I've heard, still haven't been resolved. 
> 
> I've read all about the advantages of 4K, but, so far, no one has
> really explained the _disadvantes_ to kernel developers of allowing
> people to choose their own stack size.
> 
The disadvantage of choice is that the kernel code gets more complicated.
8k stacks are two contigous pages.  So fork() have to ask for two
contigous pages, and handle cases where 8k is available but not contigous.
All that code disappear if the _choice_ is removed.  fork() and friends
will ask for 4k only - nothing special - and  either succeed or go OOM.

This was just an example, there are probably more to it.

With choice, people can have a fast 4k-stack kernel with all the advantages,
or an 8k-stack kernel that survives heavy stack usage.  But a developer
working on the VM system is slowed down by having to understand and consider 
both cases when making changes.  Someone considering only the 4k case
might break the 8k case and vice-versa.

I don't really know if we're ready for dropping 8k stack support.  
But when it happens, VM development will be a bit easier.  
Get enough such simplifications and it makes a real difference.
Collect enough choices & options, and it'll make a difference
the other way too.

Helge Hafting
