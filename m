Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289971AbSAKO6m>; Fri, 11 Jan 2002 09:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289974AbSAKO6c>; Fri, 11 Jan 2002 09:58:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8713 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289971AbSAKO6S>; Fri, 11 Jan 2002 09:58:18 -0500
Date: Fri, 11 Jan 2002 14:58:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
Message-ID: <20020111145811.B31366@flint.arm.linux.org.uk>
In-Reply-To: <20020111113131.C30756@flint.arm.linux.org.uk> <E16P1Qd-0007aL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16P1Qd-0007aL-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 11, 2002 at 01:09:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 01:09:03PM +0000, Alan Cox wrote:
> > The serial driver (old or new) open/close functions are one of the worst
> > offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
> > I'm currently working on fixing this in the new serial driver.
> 
> Someone fixed serial.c to use spinlocks a long while ago. Its just not
> merged

Unfortunately it wasn't a simple "replace global irq with spinlocks" - some
code also got moved around so its not clear that the problem was fixed by
the spinlocks or the code reordering.  I'd rather know which it was.

In addition, holding a spinlock while calling request_irq is asking for
trouble.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

