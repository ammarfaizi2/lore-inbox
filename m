Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVIMSHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVIMSHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVIMSHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:07:42 -0400
Received: from mail.aknet.ru ([82.179.72.26]:52748 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S964946AbVIMSHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:07:42 -0400
Message-ID: <43271564.7020307@aknet.ru>
Date: Tue, 13 Sep 2005 22:07:32 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
Cc: vandrove@vc.cvut.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] x86: fix ESP corruption CPU bug (take 2)
References: <431C20560200007800023E6F@emea1-mh.id2.novell.com>  <432438F0.4090003@aknet.ru>  <432546350200007800024DFF@emea1-mh.id2.novell.com> <4325B378.9080000@aknet.ru> <43269D12.76F0.0078.0@novell.com>
In-Reply-To: <43269D12.76F0.0078.0@novell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jan Beulich wrote:
> Yes, this comes close. Still, I'm more interested to understand why
> this approach was *not* chosen, which doesn't seem to be covered by any
> of the (only two) followups.
Yes, that was discussed privately.
But I am very intrigued why are you asking.
I thought this problem is very specific to
the virtualizers, like dosemu, maybe wine or
vmware, but not much more. Could you please
clarify what exactly problem does this solve
for you? I'm just curious.

As for why the other approach was developed,
here are the main points that I can recall:
- Run-time GDT patching is UGLY.
- Switching back to the 32bit stack is extremely
tricky in an NMI handler. Proving that this will
work even when the exception handler is being
NMIed, was nearly impossible (though I think I
got that part right).
- Overall the patch was so fragile and hackish-looking,
that Linus complained and proposed the plan to
get rid of the most of fragility. That included
allocating a separate per-cpu stacks and rewriting
the fixups mostly in C. He also proposed a lot of
the optimizations to make the C-based patch as
fast as an asmish one. That all made the patch
overall much better (and much bigger, too) and
helped to fix the regressions quickly (there were
quite a few, but they were not the bugs in the
patch itself :)

