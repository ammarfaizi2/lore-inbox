Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTJ3XJp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJ3XJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:09:45 -0500
Received: from gaia.cela.pl ([213.134.162.11]:4612 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262960AbTJ3XJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:09:42 -0500
Date: Fri, 31 Oct 2003 00:09:25 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Dave Brondsema <dave@brondsema.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: uptime reset after about 45 days
In-Reply-To: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
Message-ID: <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After about 45 days or so, my uptime was reset. My idle time is correct.
> 
> $ cat /proc/uptime
> 94245.37 3686026.54
> 
> $ cat /proc/version Linux version 2.4.20-gentoo-r1
> (root@dpb2.resnet.calvin.edu) (gcc version 3.2.2) #6 SMP Thu Apr 17
> 14:11:34 EDT 2003

Uptime is stored in jiffies which is 32bit on your arch, which results in 
an overflow after 2^32 clock ticks. TTTicks were 100 HZ till recently 
(overflow after 470 or so days) now, they're 1000 -> overflows after 45 
days.  Doesn't wreck anything except for uptime display - known problem, 
not worth the trouble fixing it would cause (64 bit values are 
non-atomic, unless MMX/SSE which isn't allowed in kernel) - however there 
is (if I'm not mistaken) a patch available wihich fixes this 'problem'.

However since it is only a matter of uptime display...

Cheers,
MaZe.

