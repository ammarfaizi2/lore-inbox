Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUIPMAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUIPMAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUIPL6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:58:52 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:24589 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268036AbUIPL5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:57:41 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Thu, 16 Sep 2004 14:57:08 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <20040916114515.GP9106@holomorphy.com>
In-Reply-To: <20040916114515.GP9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409161457.08544.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Specifically:
> > top on idle machine sucks ~40% CPU while in 2.4
> > it takes only ~6%
> > I recompiled 2.6 with HZ=100 and with slab debugging
> > off. This helped a bit (wget was slow too),
> > but top still hogs CPU.
> > I did 'strace -T -tt top b n 1' under both kernels,
> > postprocessed it a bit:
>
> The following patches in -mm are likely to help top(1).
>
> kallsyms-data-size-reduction--lookup-speedup.patch
>   kallsyms data size reduction / lookup speedup
>
> inconsistent-kallsyms-fix.patch
>   Inconsistent kallsyms fix
>
> kallsyms-correct-type-char-in-proc-kallsyms.patch
>   kallsyms: correct type char in /proc/kallsyms
>
> kallsyms-fix-sparc-gibberish.patch
>   kallsyms: fix sparc gibberish

Thanks.

> As for all syscalls/etc. being slower by 50%-100%, I suggest toning

s/all/many/:

uname <0.000142> š š š š š š š uname <0.000217>		25% slower
brk <0.000176> š š š š š š š š brk <0.000174>		no change
open <0.000218> š š š š š š š šopen <0.000335>		33% slower
fstat64 <0.000104> š š š š š š fstat64 <0.000191>	90% slower

or maybe strace simply isn't very accurate and adds signinficant
noise to the measured delta?

> down HZ (we desperately need to go tickless) and seeing if it persists.
> Also please check that time isn't twice as fast as it should be in 2.6.

I recompiled 2.6 with HZ=100. It's not it.
Time is running normally too.
--
vda

