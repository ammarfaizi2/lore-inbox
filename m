Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUIRTNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUIRTNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268854AbUIRTNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:13:17 -0400
Received: from mail.aknet.ru ([217.67.122.194]:38404 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268693AbUIRTNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:13:14 -0400
Message-ID: <414C8924.1070701@aknet.ru>
Date: Sat, 18 Sep 2004 23:14:44 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz>
In-Reply-To: <20040918165932.GA15570@vana.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Petr Vandrovec wrote:
>> Does this look reasonable? If it does, I think I
>> should just start implementing that.
> Do not forget that you have to implement also return to CPL1, as
> NMI may arrive while you are running on CPL1.  So it may not be
> as trivial as it seemed. 
I am not sure what special actions have to be
taken here compared to returning to ring-3 from NMI.
Is there anywhere in the sources an example to take
a look at? (sorry for the newbie questions)

> Maybe all these programs survive that
> their CPL3 stack changes,
Most likely they will, I am just not sure. What
if they disabled interrupts and are switching the
stack by loading the SS and ESP separately? If we
interrupt it there, there may be the problems, which
would be almost impossible to track down later.
It just looks a bit unsafe to me. Or maybe exploit
a sigaltstack for that? Hmm, is implementing the
CPL1 trampoline really that difficult after all?
I think it is somewhat cleaner and maybe safer.

> Only problem is how to find that old SS points to 16bit segment.
> You need LAR and/or you have to peek GDT/LDT to find stack size, 
Yes, I was thinking about using LAR - looks like the
most easy and fast way to just get that single bit
out of LDT.

> and AFAIK LAR is microcoded on P4.
Where does this lead us to? Some other problems I
am not aware about?

