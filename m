Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318739AbSHANkN>; Thu, 1 Aug 2002 09:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSHANkN>; Thu, 1 Aug 2002 09:40:13 -0400
Received: from daimi.au.dk ([130.225.16.1]:57729 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S318739AbSHANkL>;
	Thu, 1 Aug 2002 09:40:11 -0400
Message-ID: <3D493B06.3C20A88@daimi.au.dk>
Date: Thu, 01 Aug 2002 15:43:34 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <3D4419F5.3000104@yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> 
> Hello.
> 
> According to this:
> http://support.intel.com/design/intarch/techinfo/Pentium/instrefi.htm#89126
> AC flag is cleared by an INT
> instruction executed in real mode.
> The attached patch implements that
> functionality and solves some
> problems recently discussed in
> dosemu mailing list.

This sounds a little strange to me. AC is in the upper 16 bit
of the EFLAGS register, so it is not saved on an interrupt
where only lower 16 bits is saved. This means that when we
clear it on the interrupt, the value will be lost for good.

I can see the spec says it, so we'd better do that. But does
the spec make any sense? And does the CPU really loose the
AC flag on every interrupt in real mode?

A few other things got me wondering, it says there is tested
for enough space in the stack. Does this mean something like
if (SP<6) trap(); ? If it does, we should change do_int to
actually do this. And how should we actually trap if there
is not enough space for pushing values?

And does this testing apply to other instructions as well?

And it also says the IDT size is tested. But does that
concept even exist in real mode?

And finally, why do we have a 32 bit IRET instruction, but
no 32 bit INT instruction? Is that really correct?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
