Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSEXUw4>; Fri, 24 May 2002 16:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSEXUwz>; Fri, 24 May 2002 16:52:55 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:46350 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S288748AbSEXUwy>; Fri, 24 May 2002 16:52:54 -0400
Date: Fri, 24 May 2002 21:52:49 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc,patch] breaking up sched.h
Message-ID: <20020524215249.C11638@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0205242219001.30843-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:34:04PM +0200, Tim Schmielau wrote:
> While the latter three are probably better hosted in
> <linux/capability.h>, I'm unsure where to move the former two.
> <linux/irq.h> seems quite natural, but it starts with a comment
> 
>   /*
>    * Please do not include this file in generic code.  There is currently
>    * no requirement for any architecture to implement anything held
>    * within this file.
>    *
>    * Thanks. --rmk
>    */
> 
> so that seems to be no-go. Any alternative suggestions?

The problem with linux/irq.h is that it makes many assumptions about the
per-architecture irq code.  If anyone needs to include it (in its current
form), then they're accessing architecture private data that may or may
not be present.

Maybe the correct thing would be to move linux/irq.h to linux/hw_irq.h
(so it matches asm/hw_irq.h) and move request_irq() and friends into a
new linux/irq.h

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

