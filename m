Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUHIMim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUHIMim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUHIMil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:38:41 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:14484 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S266543AbUHIMij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:38:39 -0400
Message-ID: <41177028.8000905@quark.didntduck.org>
Date: Mon, 09 Aug 2004 08:38:00 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ix86 Atomic ops during DMA...
References: <Pine.LNX.4.53.0408090809520.7612@chaos>
In-Reply-To: <Pine.LNX.4.53.0408090809520.7612@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Hello,
> 
> A piece of hardware needs its interrupt status written back
> to its status register to "clear" interrupts and thus enable
> more.. This is in an uninterruptible ISR. This, of course
> can be readily accomplished by using the standard readl() and
> writel() macros.........but! If a DMA is in progress, a hardware
> debugger shows many milliseconds between the read and the write.
> 
> This allows a race condition to exist. So, how do I lock the bus
> during the read and write?  A lock on ix86 locks only the
> next instruction, not the next plus time for another lock
> which appears to be needed.
> 
> 	I need...
> 
> 	movl (%ebx), %eax	# Read status from register in ebx
> 	movl %eax, (%ebx)	# Write it back
> 
> ..to occur together without the bus being taken away by a DMA
>  operation until these two instructions are complete.

You need a single read-modify-write instruction like:

lock orl $0, addr

--
			Brian Gerst
