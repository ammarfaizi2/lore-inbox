Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290844AbSARVnC>; Fri, 18 Jan 2002 16:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290845AbSARVmw>; Fri, 18 Jan 2002 16:42:52 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:40203 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290844AbSARVmn>; Fri, 18 Jan 2002 16:42:43 -0500
Date: Fri, 18 Jan 2002 21:42:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: dan@embeddededge.com, hozer@drgw.net, linux-kernel@vger.kernel.org,
        groudier@free.fr, mattl@mvista.com
Subject: Re: pci_alloc_consistent from interrupt == BAD
Message-ID: <20020118214235.I2059@flint.arm.linux.org.uk>
In-Reply-To: <3C4875DB.9080402@embeddededge.com> <20020118.123221.85715153.davem@redhat.com> <20020118212949.H2059@flint.arm.linux.org.uk> <20020118.133306.118980313.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020118.133306.118980313.davem@redhat.com>; from davem@redhat.com on Fri, Jan 18, 2002 at 01:33:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 01:33:06PM -0800, David S. Miller wrote:
> Encapsultate the page table allocation core interfaces into
> __whatever_alloc() routines that take a GFP arg perhaps?
> It is like a 15 minute hack.

That may be, but there's all the page table manipulation code that goes
along with it as well.  Yes, a similar thing could be done with that,
it needs someone with the time to look into it and cook up a patch.

(I've got my hands full, so I'm not eager to pick this up right now).

> BTW, the USB host controller drivers do this (allocate potentially
> from interrupts) so anyone using USB on ARM...

Well, I've got a BUG() in there that'll trigger when pci_alloc_consistent()
is called from IRQ, and so far no one has reported an incidence of
that occuring, despite there being USB OHCI controllers available on ARM.
Maybe no one is pushing USB hard enough on ARM to cause these allocations,
I don't know.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

