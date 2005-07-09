Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbVGIFKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbVGIFKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 01:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGIFKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 01:10:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:48062 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263112AbVGIFKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 01:10:03 -0400
Date: Fri, 8 Jul 2005 22:09:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: dwalker@mvista.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quieten OOM killer noise
Message-Id: <20050708220943.1c2e82a5.pj@sgi.com>
In-Reply-To: <20050703173837.GB15055@krispykreme>
References: <20050723150209.GA15055@krispykreme>
	<Pine.LNX.4.10.10507031021410.5964-100000@godzilla.mvista.com>
	<20050703173837.GB15055@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
> We've had customer situations where that information would have been
> very useful.

I haven't looked closely, but when I provoked the oom killer last week
a few times while working on something else, I did notice that the
printk's that came out were a page or two, per kill.  Apparently it
is the arch-specific show_mem() routine that was so verbose - this
was on an ia64 SN2.

Do we really need that lengthy an oom printk?  If the other arch's
tend to be a little more terse, then I guess you could catalog my
complaint as a "personal problem" or at least an "arch problem."

In support of this ratelimiting, the other call from main line kernel
code to show_mem(), after the __alloc_pages() message:

	 page allocation failure. order:%d, mode:0x%x

is already ratelimited.  Seems like a good idea.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
