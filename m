Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268539AbTBOFxy>; Sat, 15 Feb 2003 00:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268542AbTBOFxy>; Sat, 15 Feb 2003 00:53:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17200 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268539AbTBOFxx>; Sat, 15 Feb 2003 00:53:53 -0500
To: Corey Minyard <cminyard@mvista.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>
	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>
	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>
	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>
	<3E4D3419.1070207@mvista.com>
	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>
	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 23:03:27 -0700
In-Reply-To: <3E4D4ADF.3070109@mvista.com>
Message-ID: <m17kc26pxs.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> writes:

> Werner Almesberger wrote:
> 
> |Zwane Mwaikambo wrote:
> |
> |>I don't think suspending devices is safe at that stage since removing
> |>devices and walking lists and freeing memory and disabling devices and...
> |>kicks up quite a storm.
> |
> |
> |If you *really* don't want to stop devices, you can use the
> |"reserved, non-DMA memory" approach, kexec the kernel that
> |records the crash dump, and then do a system-wide reset, or
> |such.
> |
> |But if you don't have that - possibly considerable - amount
> |of memory to spare, you don't have much of a choice than to
> |stop devices. Of course, crash dumps don't need a neat and
> |clean shutdown, so you can avoid all the kfrees, and such.
> |
> |(So adding a special mode to the power management code may
> |be too much overhead. Besides, sometimes, you can just pull
> |a reset line, and don't have to do anything even remotely
> |related to power management.)
> 
> True, I didn't mean the high-level power management code directly.  But the
> PCI API defines a suspend operation that could take a special mode for this.

The generic device api has a shutdown method for this.  And in the non panic
case we use it.  Not a lot of devices have it implemented but it exists.

And except that it doesn't have a restriction that it can't block is pretty
much what you want.

> Or maybe a new field in the PCI structure (and equivalent for other things, if
> there are any).  But the suspend and resume operations should at least give
> a good idea where its needed and how to use it.

The API is already done...

We just don't trust the dying kernel enough to use it during a panic.

Eric
