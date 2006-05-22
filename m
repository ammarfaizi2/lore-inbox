Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEVLAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEVLAF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWEVLAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:00:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750714AbWEVLAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:00:02 -0400
Date: Mon, 22 May 2006 03:59:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not
 working on 2.6.16
Message-Id: <20060522035943.7829ee32.akpm@osdl.org>
In-Reply-To: <4469E709.7080501@onelan.co.uk>
References: <4469E709.7080501@onelan.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Scott <barry.scott@onelan.co.uk> wrote:
>
> Under FC4's build of 2.6.13 the broadcom 5752 works well. But when the
>  I use the FC4 build of 2.6.16 it no long works.
> 
>  The hardware is an HP dc7600U, P4 2.8GHz CPU, 512MB memory
>  SATA disk.
> 
>  mii-tool correctly reports the state of the eth0. Removing and inserting the
>  cable is reported as expected. But DHCP or static IP configuration does not
>  work under 2.6.16.
> 
>  In dmesg output on 2.6.16 I see this message:
>  ADDRCONF(NETDEV_UP): eth0: link is not ready
> 
>  I have recompiled the 2.6.13 version of tg3.c for 2.6.16 and that does 
>  not fix
>  the problem.
> 
>  Looking at /proc/interrupts I see that a lot of difference between .13 
>  and .16 kernels.
>  Is this related to the problem?
> 
>  Attached are the output of dmesg and /proc/interrupts on 2.6.13 and 
>  2.6.16 kernels
>  as well as lspci output.

It appears that the 2.6.13 kernel did not bring up the machine's io-APICs,
but 2.6.16 did.  However you are receiving eth0 interrupts on 2.6.16 so
perhaps that's not relevant.

Don't know, sorry - tg3 works OK for most people.  You could try booting
with the `noapic' kernel paremeter, perhaps.

Note that googling for "noapic" gets 212,000 hits - we've _really_ screwed
something up in there.  Maybe one day some developer will lay hands on one
of these machines and will fix something.

If noapic doesn't work (and I suspect it won't) then a next step would be
to compile a kernel.org kernel and start enabling debug options.  It's
hard, when we don't know which kernel subsystem broke.

