Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUIQSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUIQSLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUIQSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 14:11:37 -0400
Received: from mail.aknet.ru ([217.67.122.194]:54277 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268851AbUIQSLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 14:11:34 -0400
Message-ID: <414B28F1.4040604@aknet.ru>
Date: Fri, 17 Sep 2004 22:12:01 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz>
In-Reply-To: <3BFF2F87096@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Petr Vandrovec wrote:
>> There is a "semi-official" bug in Intel CPUs,
>> which is described here:
>> http://www.intel.com/design/intarch/specupdt/27287402.PDF
>> chapter "Specification Clarifications"
>> section 4: "Use Of ESP In 16-Bit Code With 32-Bit Interrupt Handlers".
> Not a bug, but a feature.
Yep, one of those features, that you can
neither disable, nor (speaking about dosemu)
work around.

>> What I want to find out, is what CPUs are
>> affected. I wrote a small test-case. It is
>> attached. I tried it on Intel Pentium and
>> on AMD Athlon - bug is present on both. But
>> I'd like to know if it is also present on a
>> Transmeta Crusoe, Cyrix and other CPUs.
> AFAIK all.
I expected that. My last hopes were on Cyrix, which,
at least as I've heard, doesn't follow the Intel's
specs very strictly. So I thought maybe they have
not duplicated that "feature".

> There are products which depend on this behavior.
Out of curiosity, what are those products? I
think it is pretty much brain-damaged to depend
on a ESP corruption.

>> I'd also like to know any thoughts on whether
>> it is possible to work around the bug, probably
>> in a kernel?
> IMHO you have to switch to 16bit stack, load upper bits of ESP 
> with target value, and then execute IRET, while 16bit SS:SP points 
> to same place where flat ESP pointed.  
Hmm, that sounds feasible.

> And I do not think that linux NMI handler survives 16bit stack, so 
> natural solution seems to be to create complete 16bit CPL1 
> environment, return to it, load ESP as you want, and then do IRET 
> to return to CPL2 or CPL3.  Fortunately V8086 mode is not affected, 
> so there should be no problem with using CPL1 for this middle step.  
> But of course it is not something you want to do on each return 
> from interrupt handler...  Well, or maybe you want...
Umm, no. But well, the spec claims that this
happens only with iret. It doesn't say that it
is a general problem with switching between a
different protection rings. And it seems, for
example, that WinNT/XP do not have that problem.
I.e. the DOS progs that get a Stack Fault under
dosemu because ESP points to the kernel space, can
actually work under WinXP. Maybe they are using
some other technique to return to Ring3, the one
that doesn't trigger the bug at all?

>> Anyway, I'd be glad to get any info on that bug.
>> Why it was not fixed for so many years, looks
>> also like an interesting question, as for me.
> It is part of architecture now...
How could that happen? Was it so difficult to just
fix? Oh well, perhaps it was...

