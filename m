Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVKBSBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVKBSBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVKBSBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:01:36 -0500
Received: from [67.137.28.189] ([67.137.28.189]:10883 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751489AbVKBSBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:01:35 -0500
Message-ID: <4368EBBF.2000302@wolfmountaingroup.com>
Date: Wed, 02 Nov 2005 09:39:27 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: listmonkey@neo.relay-host.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP CPU affinity questions
References: <20051102175022.13637.qmail@neo.relay-host.net>
In-Reply-To: <20051102175022.13637.qmail@neo.relay-host.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

listmonkey@neo.relay-host.net wrote:

>Hi-
>
>I am trying to use a quad Opteron motherboard with SMP Kernel 2.6.5 for a quasi-real-time task.
>I need to assign all processes to specific CPUs, including interrupt handlers.
>I have had success using sched_setaffinity() to set the CPU for processes I create, but I am unable,
>as root, to force system processes to move to another CPU.  Any ideas?
>
>I can find no documentation about how to force an interrupt handler to a specific CPU - is this
>possible without modifying the kernel?
>
>  
>


IOApic's support binding of interrupt delivery in intel based platforms, 
but I am unaware of tools which force this
setting by default on Linux, but someone else may be able to point you 
in that direction.  Most folks code APIC ICC delivery to
AV_LOPRI (meaning lowest priority processor gets next interrupt).   This 
is advantageous for cache coherency since the IRQ code
is probaby still in that processors cache.  You may have to modify the 
kernel.  Linux doesn't allow processors to be shutdown and
reactiviated real time, it just starts them and lets them run, so you 
don;t have to worry about the case of migrating interrupts
off pinned APICs.  The APIC supports what you are asking for, but I am 
not certain anyone implemented anything other
than AV_LOPRI settings by default in the IO APIC code.  I would suggest 
you look over the IO APIC Code -- this is a lot
of work, BTW.

Jeff

>--Pete
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

