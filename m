Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSFKHuC>; Tue, 11 Jun 2002 03:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316899AbSFKHto>; Tue, 11 Jun 2002 03:49:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46094 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316902AbSFKHsF>; Tue, 11 Jun 2002 03:48:05 -0400
Date: Tue, 11 Jun 2002 08:47:58 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Double quote patches part one: drivers 1/2
Message-ID: <20020611084758.B1346@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0206102101520.20111-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 09:07:17PM -0600, Lightweight patch manager wrote:
> I spent my whole night correcting the double quotes. Someone pointed out 
> yesterday that they had to be corrected. I did a checker script and am now 
> running over the kernel.
> 
> This patch fixes broken double quotes in printk's and asm's.

Not "broken" as such.  Just "new gcc warns".

> +	" subs	%3, %3, #2          \n"
> +	" bmi	2f                  \n"
> +        "1:                         \n"

Yuck.  Yuck yuck yuck yuck yuck.

1. Spaces -> source bloat.
2. No tab at the start of the file -> yuck when reading the ASM.

My preferred way of fixing these in ARM stuff is to add <tab><tab><tab>\n\
to each line (with the appropriate number of tabs.  See
arch/arm/kernel/semaphore.c for an example.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
