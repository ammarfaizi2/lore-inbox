Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUB2IdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUB2IdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:33:15 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:41621 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262013AbUB2IdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:33:12 -0500
Date: Sun, 29 Feb 2004 16:32:54 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Cc: mgross@linux.co.intel.com, arjanv@redhat.com, tim.bird@am.sony.com,
       root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <20040226190259.7965cc76.rddunlap@osdl.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr34h04mx4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040226190259.7965cc76.rddunlap@osdl.org>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004 19:02:59 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:

> On Thu, 26 Feb 2004 17:36:34 -0800 "Grover, Andrew" <andrew.grover@intel.com> wrote:
>
> | > On Thursday 26 February 2004 13:30, Arjan van de Ven wrote:
> | > > hardware IRQ priorities are useless for the linux model. In
> | > linux, the
> | > > hardirq runs *very* briefly and then lets the softirq context do the
> | > > longer taking work. hardware irq priorities then don't matter really
> | > > because the hardirq's are hardly ever interrupted really,
> | > and when they
> | > > are they cause a performance *loss* due to cache trashing.
> | > The latency
> | > > added by waiting briefly is going to be really really short
> | > for any sane
> | > > hardware.
> |
> | Is the assumption that hardirq handlers are superfast also the reason
> | why Linux calls all handlers on a shared interrupt, even if the first
> | handler reports it was for its device?
>
> Somehow I don't think that's the reasoning.
>
> Is there a safe method to determine that there are no other pending
> interrupts on one shared interrupt?  i.e., that other devices don't
> also have interrupts pending?
>

Most interrupt controllers can read back IRQ's to see whether it is
active. A shared IRQ would be readback active while any device
connected to it desires service.

x86 example for 8259A AT-PIC's Returns the state of IRQ0-15 in ax
Note that jmp $+2 is only needed on some old 286/386 hardware
to meet (real) 8259A cycle time requirements.

- Intel syntax :)

	mov	al,0ah
	out	0a0h,al
	jmp	$+2
	in	al,0a0h
	mov	ah,al
	mov 	al,0ah
	jmp	$+2
	out 	20h,al
	jmp	$+2
	in 	al,20h

Regards
Michael

