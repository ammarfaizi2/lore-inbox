Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTJ1Btx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbTJ1Btx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:49:53 -0500
Received: from 12-221-81-65.client.insightBB.com ([12.221.81.65]:27777 "HELO
	apathy.killer-robot.net") by vger.kernel.org with SMTP
	id S263810AbTJ1Btv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:49:51 -0500
Date: Mon, 27 Oct 2003 19:49:50 -0600
From: Maciej Babinski <maciej@killer-robot.net>
To: Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: cat /proc/bus/pnp/escd -> kernel segfault (2.6 BK)
Message-ID: <20031028014950.GA1742@apathy.black-flower>
References: <20031027044204.GA23976@merlin.emma.line.org> <3F9D5458.9010704@didntduck.org> <20031027191356.GA5966@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027191356.GA5966@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 08:13:56PM +0100, Matthias Andree wrote:
> On Mon, 27 Oct 2003, Brian Gerst wrote:
> 
> > Does this patch fix it?
> 
> Unfortunately not. I am not seeing SIGSEGV or something, the machine
> freezes hard instead.
> 

I was having a simliar problem, except my machine seemed to recover
from the error. With this patch applied, I get a double-fault:

PNPBIOS fault.. attempting recovery.
double fault, gdt at c02bbe20 [255 bytes]
double fault, tss at c031ca00
eip = ca2f9e10, esp = 00000028
eax = 00000000, ebx = ca2f9e0c, ecx = 00000097, edx = c02bf11c
esi = 00000000, edi = c01187f0

Here is how the addresses resolve in /proc/kallsyms:
c02bbe20 is in _etext
c031ca00 is in km_waitq [ipv6]
ca2f9e10 is in __crc_rtc_control [rtc]
ca2f9e0c is in __crc_rtc_control [rtc]
c02bf11c is in __PAGE_KERNEL [agpgart]
c01187f0 is in do_page_fault
