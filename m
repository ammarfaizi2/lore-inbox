Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933132AbWKSUJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbWKSUJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWKSUJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:09:30 -0500
Received: from h155.mvista.com ([63.81.120.155]:48301 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S933132AbWKSUJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:09:29 -0500
Message-ID: <4560BA57.40600@ru.mvista.com>
Date: Sun, 19 Nov 2006 23:11:03 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mingo@elte.hu, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       dwalker@mvista.com
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
 type IRQ handlers
References: <200611192243.34850.sshtylyov@ru.mvista.com>	 <1163966437.5826.99.camel@localhost.localdomain> <1163966649.5826.101.camel@localhost.localdomain>
In-Reply-To: <1163966649.5826.101.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Benjamin Herrenschmidt wrote:

>>>As fasteoi type chips never had to define their ack() method before the
>>>recent Ingo's change to handle_fasteoi_irq(), any attempt to execute handler
>>>in thread resulted in the kernel crash. So, define their ack() methods to be
>>>the same as their eoi() ones...

>>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>>---
>>>Since there was no feedback on three solutions I suggested, I'm going the way
>>>of least resistance and making the fasteoi type chips behave the way that
>>>handle_fasteoi_irq() is expecting from them...

>>Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi
>>handler is being changed and what is the rationale for adding an ack
>>that was not necessary before ?

    It's changed in the RT patch for the case of threaded IRQ. This patch is 
not for the mainline kernels.

> To be more precise, I don't see in what circumstances a fasteoi type PIC
> would need an ack routine that does something different than the eoi...
> and if it always does the same thing, why not just call eoi ?

    Because Ingo decided that calling mask() and ack() methods was a better 
than calling mask() and eoi(). Here's the thread:

http://ozlabs.org/pipermail/linuxppc-dev/2006-October/026546.html

> Ben.

WBR, Sergei

