Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSGVODE>; Mon, 22 Jul 2002 10:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSGVODE>; Mon, 22 Jul 2002 10:03:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13834 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317406AbSGVODD>; Mon, 22 Jul 2002 10:03:03 -0400
Message-ID: <3D3C0FF8.1040301@evision.ag>
Date: Mon, 22 Jul 2002 16:00:24 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
References: <Pine.LNX.4.44.0207221544090.9136-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> On Mon, 22 Jul 2002, Christoph Hellwig wrote:
> 
> 
>>yupp, you're right.  could you take the prototype changes anyway?
> 
> 
> i'm hesitant for a number of reasons. Eg. irq_save_off(flags) has to be a
> macro, otherwise we move the assignment into the irqs-off section.  
> Compare:
> 
> 	flags = irq_save_off();
> 
> with:
> 	irq_flags_off(flags);
> 
> sure, it could be written as:
> 
> 	flags = irq_save();
> 	irq_off();
> 
> but then again the macro form is more compact.


By 2 characters. And hiding the side-effect. We don't have the notion of
var argument passing like in pascal or C++ here.

