Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRI0IQD>; Thu, 27 Sep 2001 04:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272020AbRI0IPy>; Thu, 27 Sep 2001 04:15:54 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:59619 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271995AbRI0IPl>; Thu, 27 Sep 2001 04:15:41 -0400
Date: Thu, 27 Sep 2001 09:16:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Armin Schindler <mac@melware.de>
Cc: Ingo Molnar <mingo@elte.hu>,
        =?iso-8859-1?Q?=CA=E6=B9=FA=C7=BF?= <guoqiang@intec.iscas.ac.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Question about ioremap and io_remap_page_range
Message-ID: <20010927091601.A6499@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0109270847070.2745-100000@localhost.localdomain> <Pine.LNX.4.31.0109271001001.25611-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0109271001001.25611-100000@phoenix.one.melware.de>; from mac@melware.de on Thu, Sep 27, 2001 at 10:03:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 10:03:26AM +0200, Armin Schindler wrote:
> virt_to_phys() is obsolete ? What should be used if I need the phys address
> of a memory page ? (e.g. for mmap() remapping)

virt_to_phys is only valid on the kernel direct mapped RAM area - memory
returned from kmalloc and non-highmem memory returned from get_free_page.

Since vmalloc and ioremap do not return a pointer into the direct mapped
RAM area, but its own mapping, it is not valid to use virt_to_phys on
these returned values, even through it might be a virtual address.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

