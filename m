Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289327AbSAKLb7>; Fri, 11 Jan 2002 06:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289349AbSAKLbt>; Fri, 11 Jan 2002 06:31:49 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:11272 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289327AbSAKLbj>; Fri, 11 Jan 2002 06:31:39 -0500
Date: Fri, 11 Jan 2002 11:31:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
Message-ID: <20020111113131.C30756@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Jan 11, 2002 at 01:38:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 01:38:51AM +0100, Ingo Molnar wrote:
> it adds code to catch places that call schedule() from global-cli()
> sections. Right now release_kernel_lock() doesnt automatically release the
> IRQ lock if there is no kernel lock held. A fair amount of code does this
> still, and i think we should fix them in 2.5.

The serial driver (old or new) open/close functions are one of the worst
offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
I'm currently working on fixing this in the new serial driver.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

