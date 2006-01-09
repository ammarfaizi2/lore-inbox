Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWAINAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWAINAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWAINAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:00:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19178 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbWAINAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:00:49 -0500
Date: Mon, 9 Jan 2006 05:00:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "ODonnell, Michael" <Michael.ODonnell@stratus.com>
Cc: adapter_support@intel.com, bonding-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-netdev@lists.sourceforge.net,
       John Ronciak <john.ronciak@intel.com>,
       Ganesh Venkatesan <ganesh.venkatesan@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH] corruption during e100 MDI register access
Message-Id: <20060109050030.77a3104d.akpm@osdl.org>
In-Reply-To: <92952AEF1F064042B6EF2522E0EEF437032252ED@EXNA.corp.stratus.com>
References: <92952AEF1F064042B6EF2522E0EEF437032252ED@EXNA.corp.stratus.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"ODonnell, Michael" <Michael.ODonnell@stratus.com> wrote:
>
> We have identified two related bugs in the e100 driver and we request
>  that they be repaired in the official Intel version of the driver.
> 
>  Both bugs are related to manipulation of the MDI control register.
> 
>  The first problem is that the Ready bit is being ignored when
>  writing to the Control register; we noticed this because the Linux
>  bonding driver would occasionally come to the spurious conclusion
>  that the link was down when querying Link State.  It turned out
>  that by failing to wait for a previous command to complete it was
>  selecting what was essentially a random register in the MDI register
>  set.  When we added code that waits for the Ready bit (as shown in
>  the patch file below) all such problems ceased.
> 
>  The second problem is that, although access to the MDI registers
>  involves multiple steps which must not be intermixed, nothing was
>  defending against two or more threads attempting simultaneous access.
>  The most obvious situation where such interference could occur
>  involves the watchdog versus ioctl paths, but there are probably
>  others, so we recommend the locking shown in our patch file.

Your patches are coming through wordwrapped.  Please fix your email client
in future.

Please also prepare patches in `patch -p1' form. 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt may prove useful.

This patch potentially spins for four milliseconds with interrupts off,
which will be unpopular.  Is there no alternative?

Anyway, I queued the patch in my kernel so the issue won't be forgotten
about.  I also queued a patch which makes your patch comply with kernel
coding style - it wasn't very close at all.

Thanks.
