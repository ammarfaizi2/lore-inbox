Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVE2SL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVE2SL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVE2SL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:11:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:40331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261401AbVE2SLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:11:05 -0400
Date: Sun, 29 May 2005 11:12:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
In-Reply-To: <1117291619.9665.6.camel@localhost>
Message-ID: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 May 2005, Pekka Enberg wrote:
> 
> I did a binary search and found out that 2.6.10-bk10 introduced this
> bug. The kernel includes Linus' changes for pipes to use circular buffers.
> A oprofile run shows that kernel is spending lots of time in poll_pipe. I
> also have Alt-Sysrq-P traces that indicate to the same direction. I have
> included vmstat, Alt-SysRq-P, and oprofile traces in this mail (see below
> for section X.).

Can you try to see if you can get an "strace" snippet of X (or the window
manager) when this happens, since it seems to reproducible by you..

Also, I actually find it very surprising that you see X doing anything
_at_all_ with a pipe, since all the X connections should be just normal
sockets. There are no pipes involved anywhere afaik.

Your description sounds exactly like X is busy processing some slow
operation (or possibly the window manager, but I think virtual console
switches happen without the WM being involved). The most common such slow 
operation is a new font being generated, but I don't see why that would 
have anything to do with pipes either...

		Linus
