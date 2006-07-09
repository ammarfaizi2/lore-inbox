Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWGINYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWGINYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 09:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWGINYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 09:24:19 -0400
Received: from 1wt.eu ([62.212.114.60]:1802 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1030492AbWGINYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 09:24:17 -0400
Date: Sun, 9 Jul 2006 15:23:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>,
       chase.venters@clientec.com, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Message-ID: <20060709132352.GA23263@1wt.eu>
References: <20060709121511.GD2037@1wt.eu> <BKEKJNIHLJDCFGDBOHGMCEFIDCAA.abum@aftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMCEFIDCAA.abum@aftek.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 06:42:23PM +0530, Abu M. Muttalib wrote:
> >It's explained in Documentation/filesystems/proc.txt. This file know far
> >ore things than me :-)
> 
> I tried with overcommit_ratio=100 and overcommit_memory=2 in that sequence.
> 
> but the applications were killed. :-(

If you set it too high, the system will never fail a malloc() and the memory
will quickly be grabbed by memory eaters, thus quickly resulting in OOM. This
is the default behaviour.

If you set it too low, the system will fail malloc() calls eventhough there
might be enough memory left, so you cannot start new processes.

Setting it to an intermediate value helps the system manage its ressources
and helps applications know that they must be smart with their memory usage.
For instance, if your application has something like a garbage collector or
can automatically reduce its buffers when memory becomes scarce, then it
will be helped by a lower overcommit_ratio. If your application does not
run as root, you might also try to play with ulimit -v before starting it.
I use this in my load balancing reverse proxy to restrain memory usage
without impacting the rest of the system.

Memory tuning in constrainted environments is like rocket science. You need
some evaluations then to make a lot of experimentations. There is no rule
which will work for everyone. But it seems to me that your application is
not very resistant in those environments. Maybe 2.4.19 was very close to
the ressource limit and now 2.6.13 has crossed the boundary. You can also
try to play with the -tiny patches (merged around 2.6.15 IIRC) to reduce
the kernel's memory usage.

> Regards,
> Abu.

Regards,
Willy

