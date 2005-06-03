Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFCFTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFCFTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFCFTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:19:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8664 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261266AbVFCFSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:18:55 -0400
Date: Fri, 3 Jun 2005 07:18:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
Message-ID: <20050603051821.GC14059@elte.hu>
References: <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFB66.8030909@stud.feec.vutbr.cz> <20050602123927.GB10878@elte.hu> <429F4A19.7030508@stud.feec.vutbr.cz> <20050602183343.GB30309@elte.hu> <429F8C00.3070803@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429F8C00.3070803@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> >hm, one difference is that i'm running a 64-bit kernel but 32-bit 
> >userspace (FC3-ish).
> 
> Yes, that's it! I've just successfully booted into 32-bit userspace (I 
> have a separate partition with old 32-bit Debian) with x86_64 kernel and 
> LATENCY_TRACE enabled. Everything seemed to work.
> Then I mounted my normal root partition under /mnt/64 and tried
>   chroot /mnt/64
> I got a SIGSEGV. Then I copied some simple binaries from /mnt/64/bin to 
> /root/test/bin and some necessary libraries to /root/test/lib and did
>   chroot /root/test
> I could run 64-bit sash, ls, cat, date, mkdir - it worked. 64-bit bash 
> however segfaulted.

perhaps my mcount stubs dont save enough registers, leading to register 
corruption on 64-bit userspace? In that case i'd expect more breakage 
though, so maybe it's something more subtle.

	Ingo
