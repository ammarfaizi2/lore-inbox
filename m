Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUIWWfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUIWWfK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIWWca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:32:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:51403 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267482AbUIWWaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:30:13 -0400
Date: Fri, 24 Sep 2004 00:30:12 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Bad RIP on x86-64
Message-ID: <20040923223012.GC26406@wotan.suse.de>
References: <1095975016.674.14.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095975016.674.14.camel@boxen>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <1>Unable to handle kernel NULL pointer dereference at 0000000000000286 RIP: 
> [<0000000000000286>]
> PML4 3b551067 PGD 3b553067 PMD 0 
> Oops: 0010 [1] PREEMPT SMP 
> CPU 1 
> Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii crc32 e1000
> Pid: 596, comm: xfce-mcs-manage Not tainted 2.6.9-rc2-mm1
> RIP: 0010:[<0000000000000286>] [<0000000000000286>]

Someone corrupted the stack most likely, overwriting the return
address. When the function returned it jumped to nirvana.

I would look for any new functions that manipulate arrays on the stack
and double check them.  Suggest you revert the staircase patch and try again.


-Andi
