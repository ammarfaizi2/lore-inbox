Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbTCAR2J>; Sat, 1 Mar 2003 12:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268922AbTCAR2J>; Sat, 1 Mar 2003 12:28:09 -0500
Received: from a.smtp-out.sonic.net ([208.201.224.38]:54175 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S268916AbTCAR2I>; Sat, 1 Mar 2003 12:28:08 -0500
X-envelope-info: <dhinds@sonic.net>
Date: Sat, 1 Mar 2003 09:38:28 -0800
From: David Hinds <dhinds@sonic.net>
To: Pavel Roskin <proski@gnu.org>
Cc: David Hinds <dahinds@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
Message-ID: <20030301093814.A6700@sonic.net>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 08:30:36PM -0500, Pavel Roskin wrote:
> 
> David, I understand from the Linux MAINTAINERS file that you also maintain
> the PCMCIA code in the kernel.  It's quite strange for me, because the
> kernel code is quite different from what I used to see in pcmcia-cs.

Well, I'd have to say that I feel a little squeemish about being
called the maintainer of the kernel code because I don't feel I can
devote the time to it that it needs.  If someone else is willing to
step up I'd happily cede the job to them.

> yenta_socket in 2.5.63 knows different models of the bridges and sets IRQ
> routing to PCI for certain models.  I don't really like this approach.

I have not looked at the most recent 2.5.* kernels but if that is true
then you're right, it is ill conceived.

> The chip can be integrated into the motherboard, and we don't know if the
> ISA IRQ lines are connected or not.  The architecture may not support ISA
> bus (e.g. PowerPC), then there will be no ISA interrupts, no matter what
> chip is used.

Which raises an issue I've been wondering about, how to tell when a
kernel is being built for a system with ISA bus capabilities.  The
current code checks CONFIG_ISA but that's probably a bad idea.

> I believe using PCI interrupts should not be considered as an inferior
> approach compared to ISA interrupts.  The only driver I know that had
> problems with PCI interrupts was ide-cs, but it's now fixed in the Alan's
> tree, and hopefully in 2.4.21-pre5 (I didn't have a chance to test it).
> 
> Anyway, for the sake of backward compatibility, let's consider using PCI
> interrupts a fallback that we use only if ISA interrupts don't work.

This sounds fine to me.  I'd be concerned about giving up ISA
interrupts completely, that some of the less used drivers have never
been tested for compatibility with shared interrupts.

-- Dave
