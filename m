Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSEUSxg>; Tue, 21 May 2002 14:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSEUSxf>; Tue, 21 May 2002 14:53:35 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:46087 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315431AbSEUSxe>; Tue, 21 May 2002 14:53:34 -0400
Message-ID: <3CEA993D.5060705@yahoo.com>
Date: Wed, 22 May 2002 00:30:13 +0530
From: C Hanish Menon <hanishkvc@yahoo.com>
Reply-To: hanishkvc@yahoo.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020515 Debian/1.0rc2-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Seems like a race or unhandled situation with ksoftirqd scheduling/management
 - Oops missed the control flow in the generic irq.c as most targets use their
 own irq.c 
In-Reply-To: <3CEA8742.2040308@yahoo.com.suse.lists.linux.kernel> <p73hel1xswv.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi

Andi Kleen wrote:
> At least i386 runs the softirqs at the end of do_IRQ.
> 
> ksoftirqd is just supposed to be a fallback mechanism for the case
> of soft irqs eating excessive runtime or one softirq triggering another
> (common case is networking and serial softirq for BH). It is not
> the primary way to run softirqs.

Oops, You are right, i386 and also the generic mips irq.c has code in
do_IRQ to call do_softirq.

But most of the target specific irq.c in mips, don't seem to follow this 
convention. Even when I started my port, I had based my interrupt 
subsystem after looking into some of these target specific irq.c's.

So I was expecting this call to softirqs occuring from within 
kernel/entry.S after ret_from_irq. And as there is no code there to this
end, I came to my flawed conclusion.

Sorry about this wrong assumption.
I have got the solution to my problem. However have to check out with 
the mips target guys has to how they are taking care of softirqs. When
they aren't calling do_softirq from do_IRQ or any other part of 
interrupt subsystem.

Keep :-)
HanishKVC


