Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVL3K7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVL3K7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 05:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVL3K7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 05:59:12 -0500
Received: from general.keba.co.at ([193.154.24.243]:32557 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750819AbVL3K7L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 05:59:11 -0500
Content-class: urn:content-classes:message
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Fri, 30 Dec 2005 11:59:07 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330B@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNE821zrVGUtjyTbmyihG8u6Lr9AAGmtgA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Molnar
> * Lee Revell <rlrevell@joe-job.com> wrote:
> > > However, traces 1, 2, 6 and 7 are completely mysterious to me.
> > > Interrupts seem to be blocked for milliseconds, while 
> nothing is going
> > > on on the system? Moreover, there are console-related 
> function names
> > > in
> > > traces 6 and 7, although I've unconfigured the 
> framebuffer console for
> > > these runs!
> > 
> > It seems that either some code path really is forgetting to 
> re-enable 
> > interrupts, or there's a bug in the latency tracer.
> 
> one question is, what do the kernel addresses visible in the first 
> argument of asm_do_IRQ() correspond to:
> 
>  trace1:MyThread-153   0D..1 5977us+: asm_do_IRQ (c030c170 1a 0)
>  trace1:MyThread-153   0D..1 15191us+: asm_do_IRQ (c030c1bc 1a 0)
>  trace2:  <idle>-0     0D..2 8822us+: asm_do_IRQ (c021da24 1a 0)
>  trace2:  <idle>-0     0Dn.2 8920us+: asm_do_IRQ (c021da24 b 0)
>  trace3:     top-169   0D..1 8802us+: asm_do_IRQ (c024e5fc 1a 0)
>  trace4:  insmod-185   0D..1 8794us+: asm_do_IRQ (c030c174 1a 0)
>  trace5:      dd-197   0D..1 8812us+: asm_do_IRQ (c02e4938 1a 0)
>  trace6: kthread-11    0d..3 2670us+: asm_do_IRQ (c02fe2d0 1a 0)
>  trace7:MyThread-95    0D..1  542us+: asm_do_IRQ (c02fe2d0 1a 0)
>  trace7:MyThread-95    0D..1 9755us+: asm_do_IRQ (c02fe2d0 1a 0)
> 
> i.e. what is c02fe2d0, c021da24, c02e4938, etc.?

I do not have that kernel or configuration any longer,
so I cannot look those addresses up.

I recreated a similar kernel, did similar experiments, got
similar traces, looked up the new addresses.

The one in the "<idle>-0" trace is "cpu_idle".

The others I got were mostly related to the load on the system,
all over the kernel:
Floating point emulator (call_fpe, float64_to_float32, ...),
jffs2 (deflate_fast, ...), console write (several places within
sa1100_console_write).

The strange ones in my new experiments were "mcount" and
"notify_die".

Do you need more of them?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
