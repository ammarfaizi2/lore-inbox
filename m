Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUD0Opb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUD0Opb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUD0Opb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:45:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:31617 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264117AbUD0Op3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:45:29 -0400
Date: Tue, 27 Apr 2004 10:47:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to handle interrupts  on SMP systems
In-Reply-To: <1118873EE1755348B4812EA29C55A9721D6CC7@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0404271041100.4784@chaos>
References: <1118873EE1755348B4812EA29C55A9721D6CC7@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Srinivas G. wrote:

>
> Hi,
>
> We developed a driver for PCIHOTLINK card under linux kernel 2.4.18-3.
> It was working fine under it. Now our idea is to port it SMP system with
> the same kernel. We ported. It was compiled without any problem under
> SMP system. But it is not generating any interrupts. We have changed the
> Makefile also. We added -D__SMP__ macro and -DCONFIG_SMP macro in
> Makefile. No compilation errors. But interrupts are not generating.
>
> If anybody will have any idea please let me know.
>
> Thanks in advance,
>
> Regards,
>
> Srinivas G

There is no difference between SMP and non-SMP systems as far
as interrupt generation is concerned. You might have a hardware-
initialization bug that shows up only when you use some SMP
macros. Make sure you are using the proper macros to access your
hardware and not just pretending the return value of ioremap_nocache()
is a pointer (it's not, it's a cookie).

Also SMP adds some additional code. So, it might change the
degree of optimization that the compiler performs. You need to
use the 'volatile' key-word in cases where the compiler might
not otherwise know that something could get changed in an
interrupt.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


