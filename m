Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWFGFFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWFGFFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWFGFFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:05:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750860AbWFGFFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:05:18 -0400
Date: Tue, 6 Jun 2006 21:58:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: y-goto@jp.fujitsu.com, mbligh@google.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org, 76306.1226@compuserve.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Gerd Hoffmann <kraxel@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: sparsemem panic in 2.6.17-rc5-mm1 and -mm2
Message-Id: <20060606215813.9bfe07af.akpm@osdl.org>
In-Reply-To: <20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060605200727.374cbf05.akpm@osdl.org>
	<20060606141922.c5fb16ad.kamezawa.hiroyu@jp.fujitsu.com>
	<20060606142347.2AF2.Y-GOTO@jp.fujitsu.com>
	<20060606002758.631118da.akpm@osdl.org>
	<20060607094355.b77ed883.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 09:43:55 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> On Tue, 6 Jun 2006 00:27:58 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > I tried sparsemem on my little x86 box here.  Boots OK, after fixing up the
> > kswapd_init() patch (below).
> > 
> > I'm wondering why I have 4k of highmem:
> > 
> 
> Could you show /proc/iomem of your 4k HIGHMEM box ?
> Does 4k HIGHMEM exist only when SPARSEMEM is selected ?

Turns out that my 4 kbyte highmem zone (at least, as reported in
/proc/meminfo) is due to

vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch

I don't think that was intended.

It'll be a screwup in the handling of MAXMEM.  That patch is doing strange
things with MAXMEM.  They are unchangelogged, uncommented and
possibly-hacky-looking things too, so I have no intention of fixing it.

