Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSDDTgP>; Thu, 4 Apr 2002 14:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSDDTgF>; Thu, 4 Apr 2002 14:36:05 -0500
Received: from ppp77-4-71.miem.edu.ru ([194.226.32.71]:6528 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S310517AbSDDTf6>;
	Thu, 4 Apr 2002 14:35:58 -0500
Message-ID: <3CACA4CB.9010301@yahoo.com>
Date: Thu, 04 Apr 2002 23:08:59 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
Reply-To: stas.orel@mailcity.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Kasper Dupont <kasperd@daimi.au.dk>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre4-ac4
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kasper Dupont wrote:
>> Linux 2.4.19pre4-ac4
>    > o       Fix an additional vm86 case                     (Stas Sergeev)
>    >         | Check DOSemu again and this code wants some good review
>    [...]
This patch have nothing to do with your
and Manfred's exception handling fixes.
You can find it here if you want to have
a look:
http://dosemu.sourceforge.net/~stas/traps.diff
It prevents Oops in some cases, esp. if the
invalid instruction is executed in vm86.

> I do consider the simplification to be safe.
>    In that case the macro would get to look like this:
>    #define CHECK_IF_IN_TRAP \
>            if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
>                    newflags |= TF_MASK;
I think you are right: already popped value must
not make sense in the stack and even if it does,
it seems to be even better if the TF is not set
there, so that we have the value exactly which was
pushed.

> This is assuming Stas' way to use the macro. However since it
>    looks like Stas' use the old macro, I think his code is buggy.
The real bug was that set_vflags_long/short were used before
the registers are changed, but they could return to
userspace via set_IF() leaving the instuction executed
only partially (not executed at all). This rendered vm86()
disfunctional so that dosemu fails to even start in pre3-ac6.
I have moved them down to fix the problem.
The macro was forgotten to update:(

> And BTW does anybody happen to
>    know some software actually using the feature implemented by
>    CHECK_IF_IN_TRAP?
dosemu's dosdebug uses it for force trace over iret
and probably nobody else.

> I would appreachiate some comments on this subject.
I think that your simplification for this macro is
the best fix if someone really wants to use this
dosdebug's traceing feature.
Thank you.
