Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWGMHaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWGMHaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGMHaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:30:05 -0400
Received: from mail.gmx.de ([213.165.64.21]:45956 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751021AbWGMHaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:30:02 -0400
X-Authenticated: #14349625
Subject: Re: Very long startup time for a new thread
From: Mike Galbraith <efault@gmx.de>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030B55B0@exmail1.se.axis.com>
References: <BFECAF9E178F144FAEF2BF4CE739C668030B55B0@exmail1.se.axis.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 09:36:03 +0200
Message-Id: <1152776163.8627.38.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 08:07 +0200, Mikael Starvik wrote:
> (This is on a 200 MIPS embedded architecture).
> 
> On a heavily loaded system (loadavg ~4) I create a new pthread. In this
> situation it takes ~4 seconds (!) before the thread is first scheduled in
> (yes, I have debug outputs in the scheduler to check that). In a 2.4 based
> system I don't see the same thing. I don't have any RT or FIFO tasks. Any
> ideas why it takes so long time and what I can do about it?

If your new thread is runnable but not selected for those ~4 seconds, it
could be the interactivity code.  Try disabling that.

If you want to try a patch that targets this area, I have an old one for
2.6.16 you can play with.  With it, you can pretty much disable the
interactivity code without losing dynamic priority adjustment.  I also
have one for 2.6.17, and that one removes the interactivity code
entirely (hmm) but it also actively intervenes in scheduling decisions,
so might not be a good diagnostic.

	-Mike

