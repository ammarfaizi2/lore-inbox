Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUE0OSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUE0OSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbUE0OSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:18:44 -0400
Received: from mail5.iserv.net ([204.177.184.155]:1479 "EHLO mail5.iserv.net")
	by vger.kernel.org with ESMTP id S264550AbUE0OSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:18:40 -0400
Message-ID: <40B5F8C0.2010005@didntduck.org>
Date: Thu, 27 May 2004 10:18:40 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ingo Molnar <mingo@elte.hu>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random>
In-Reply-To: <20040527135930.GC3889@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

> On Thu, May 27, 2004 at 02:45:51PM +0200, Ingo Molnar wrote:
> 
>>are a bit belated. I only reacted to Andrea's mail to clear up apparent
>>misunderstandings about the impact and implementation of this feature.
> 
> 
> note that there is something relevant to improve in the implementation,
> that is the per-cpu irq stack size should be bigger than 4k, we use 16k
> on x86-64, on x86 it should be 8k. Currently you're decreasing _both_
> the normal kernel context and even the irq stack in some condition.
> There's no good reason to decrease the irq stack too, that's cheap, it's
> per-cpu.

The problem on i386 (unlike x86-64) is that the thread_info struct sits 
at the bottom of the stack and is referenced by masking bits off %esp. 
So the stack size must be constant whether in process context or IRQ 
context.

--
				Brian Gerst
