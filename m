Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUK1Qvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUK1Qvb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUK1Qoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:44:54 -0500
Received: from [220.248.27.114] ([220.248.27.114]:2528 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261521AbUK1Q14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:27:56 -0500
Date: Mon, 29 Nov 2004 00:25:58 +0800
From: hugang@soulinfo.com
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software suspend patch [1/6]
Message-ID: <20041128162558.GF28881@hugang.soulinfo.com>
References: <20041127220752.16491.qmail@science.horizon.com> <20041128082912.GC22793@wiggy.net> <20041128113708.GQ1417@openzaurus.ucw.cz> <20041128162320.GA28881@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128162320.GA28881@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 12:23:20AM +0800, hugang@soulinfo.com wrote:
> Hi Pavel Machek, Nigel Cunningham:
> 
>  device-tree.diff 
>    base from suspend2 with a little changed.
> 
>  core.diff
>   1: redefine struct pbe for using _no_ continuous as pagedir.
>   2: make shrink memory as little as possible.
>   3: using a bitmap speed up collide check in page relocating.
>   4: pagecache saving ready.
> 
>  i386.diff
>  ppc.diff
>   i386 and powerpc suspend update.
> 
>  pagecachs_addon.diff
>   if enable page caches saving, must using it, it making saving
>   pagecaches safe. idea from suspend2.
> 
>   ppcfix.diff
>   fix compile error. 
>   $ gcc -v
>    .... 
>    gcc version 2.95.4 20011002 (Debian prerelease)
> 
> I'm using 2.6.9-ck3 With above patch, swsusp1 works prefect in my 
> PowerPC and x86 PC with Highmem and prepempt option enabled.
> 
> I hope the core.diff@1,@2,@3 i386.diff ppc.diff will merge into 
> mainline kernel ASAP, :). from I view point device-tree.diff is 
> very usefuly when using pagecache saving and pagecachs_addon.diff
> that's really hack for making pagecache saving safe.
> 

--- 2.6.9-lzf/arch/ppc/syslib/open_pic.c	2004-11-26 12:32:58.000000000 +0800
+++ 2.6.9/arch/ppc/syslib/open_pic.c	2004-11-28 23:16:58.000000000 +0800
@@ -776,7 +776,8 @@ static void openpic_mapirq(u_int irq, cp
 	if (ISR[irq] == 0)
 		return;
 	if (!cpus_empty(keepmask)) {
-		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
+		cpumask_t irqdest;
+		irqdest.bits[0] = openpic_read(&ISR[irq]->Destination);
 		cpus_and(irqdest, irqdest, keepmask);
 		cpus_or(physmask, physmask, irqdest);
 	}
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
