Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUEMFTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUEMFTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUEMFTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:19:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:57791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263778AbUEMFTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:19:45 -0400
Date: Wed, 12 May 2004 22:19:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: odd problem with dd, kernels 2.6.5-mm6, 2.6.6 maybe others
Message-Id: <20040512221916.37ee96fc.akpm@osdl.org>
In-Reply-To: <200405120928.00764.gene.heskett@verizon.net>
References: <200405120928.00764.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> Greetings;
> 
> I'm apparently having tape problems, and dd is one of the tools I use 
> to fix things.  Unforch, when /dev/nst0 has reported an error during 
> the amcheck cycle, on 2 of the 4 tapes that it read just fine 
> yesterday, and then I do a rewind on one of them, and issue a 'dd 
> if=/dev/nst0 count=1' which *should* spit out the tape header 
> onscreen, what I'm actually getting is that nothing touches the drive 
> as far as moving the tape or changing the "Ready 1" display on the 
> face of the changer, but I do have a hung dd that can only be gotten 
> rid of by a reboot.
> 
> It cannot be killed, not even with a -9.  I do not know if this is a 
> new development in kernel history or not, but it sure is a PITA.
> 
> Its been hung for about 20 minutes now.
> 
> Is there anything that I as a big dummy can do to remedy this?

Please ensure that the kernel was built with CONFIG_KALLSYMS, wait for the
hang, do: 

	echo 1 > /proc/sys/kernel/sysrq
	dmesg -c > /dev/null
	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

and send foo.
