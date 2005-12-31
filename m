Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVLaWB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVLaWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLaWB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:01:56 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:47854 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965046AbVLaWB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:01:56 -0500
Date: Sun, 1 Jan 2006 00:01:52 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20051231220152.GA3147@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B6B669.6020500@ns666.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 07:43:43PM +0100, Jiri Slaby wrote:
> >Hi Sami,
> >
> >That caused also a crash, i kept pressing the v key and within 15
> >seconds it crashed, then i saw the crash-info appear in the log and when
> >i clicked on mozilla then it crashed too but without crahs info and
> >system froze totally.
> >
> >Below the crash info:
> >
> >Dec 31 17:38:32 localhost kernel: Unable to handle kernel paging request
> >at virtual address c8111000
> >Dec 31 17:38:32 localhost kernel:  printing eip:
> >Dec 31 17:38:32 localhost kernel: c036037a
> >Dec 31 17:38:32 localhost kernel: *pgd = 21063
> >Dec 31 17:38:32 localhost kernel: *pmd = 21063
> >Dec 31 17:38:32 localhost kernel: *pte = 8111000
> >Dec 31 17:38:32 localhost kernel: Oops: 0002 [#4]
> [snip]
> Could you try the attached patch?
> 
> --
> diff --git a/drivers/media/video/bttv-risc.c b/drivers/media/video/bttv-risc.c
> --- a/drivers/media/video/bttv-risc.c
> +++ b/drivers/media/video/bttv-risc.c
> @@ -53,7 +53,7 @@ bttv_risc_packed(struct bttv *btv, struc
>  	/* estimate risc mem: worst case is one write per page border +
>  	   one write per scan line + sync + jump (all 2 dwords) */
>  	instructions  = (bpl * lines) / PAGE_SIZE + lines;
> -	instructions += 2;
> +	instructions += 4;
>  	if ((rc = btcx_riscmem_alloc(btv->c.pci,risc,instructions*8)) < 0)
>  		return rc;

This patch has the effect that xawtv crashed system two times faster
than earlier... now we're at two seconds.  

-- 
