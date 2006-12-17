Return-Path: <linux-kernel-owner+w=401wt.eu-S1752499AbWLQMFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbWLQMFc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbWLQMFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:05:32 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:54853 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbWLQMFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:05:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OdqpgMMyDPHtuJdOzlnJPZAfwpg3Uf51s4Q0m3fCpF9tpLKMi6lOVc1lwFXeudh3VH56lUdmLLTaUYS2YwPSs5lG6fWvES+mGHaPvSpQ7+yBbpudo4OC1N3rbUlcT4Az/Bh+q3+vofJ2uwZZfMs2NgCIW5QXBZAgj8gon5NRZ+Y=
Message-ID: <b0943d9e0612170405i1360d63cja04d78749ff280f8@mail.gmail.com>
Date: Sun, 17 Dec 2006 12:05:30 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061217094143.GA15372@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
	 <20061217092828.GA14181@elte.hu> <20061217094143.GA15372@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> it would also be nice to have more information than this:
>
>  unreferenced object 0xf76f5af8 (size 512):
>   [<c0191f23>] memleak_alloc
>   [<c018eeaa>] kmem_cache_zalloc
>   [<c03277a7>] probe_hwif
>   [<c032870c>] probe_hwif_init_with_fixup
>   [<c032aea1>] ide_setup_pci_device
>   [<c0312564>] amd74xx_probe
>   [<c069c4b4>] ide_scan_pcidev
>   [<c069c505>] ide_scan_pcibus
>   [<c069bdca>] ide_init
>   [<c0100532>] init
>   [<c0105da3>] kernel_thread_helper
>   [<ffffffff>]

BTW, I think there is a call to kzalloc in probe_hwif and it is
optimised to do a kmem_cache_zalloc in include/linux/slab_def.h. The
latest kmemleak-0.13 ifdef's out this optimisation because the size
information gets lost otherwise. The slab.h file was already patched
for this in 2.6.19 but its content was moved to slab_def.h in
2.6.20-rc1.

> it would be nice to record 1) the jiffies value at the time of
> allocation, 2) the PID and the comm of the task that did the allocation.
> The jiffies timestamp would be useful to see the age of the allocation,
> and the PID/comm is useful for context.

I'll add them. Thanks.

-- 
Catalin
