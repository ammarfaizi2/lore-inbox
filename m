Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVKTSic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVKTSic (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVKTSic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:38:32 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:24721 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750792AbVKTSib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:38:31 -0500
Date: Sun, 20 Nov 2005 11:14:25 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
Message-ID: <20051120101424.GA6653@stiffy.osknowledge.org>
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <Pine.LNX.4.61.0511182214200.4797@goblin.wat.veritas.com> <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc1-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hugh@veritas.com> [2005-11-19 19:57:02 +0000]:

> On Fri, 18 Nov 2005, Hugh Dickins wrote:
> > 
> > Thanks for the info you've sent so far, implicating
> > snd_pcm_mmap_data_nopage.  But I've still not got it.  Will resume
> > tomorrow.  If you can, would you please each send me your .config
> > and your full startup dmesg (in case they help to focus me on which
> > paths to look down in sound).  You needn't spam akpm or lkml with them.
> 
> And thanks for the further info you sent, which allowed me to rebuild my
> kernel to reproduce the problem easily with artsd.  Though the answer was
> staring me in the face from the first info you sent (and did occasionally
> flit through my mind without being properly swatted), even in my Subject
> line above: why were the page flags 0x414 instead of 0x4414 i.e. what had
> happened to the PageCompound flag which I thought one of my patches was
> adding?
> 
> Whoops, I'd completely missed that now we have to pass __GFP_COMP to
> turn on that behaviour, because there are or were a few other places
> which get confused by compound page behaviour.  There's an excellent,
> illuminating, prescient comment on compound pages by Andrew in
> ChangeLog-2.6.6: but though he there foresees sound DMA buffers needing
> it, I've a suspicion that DRM and some others might also be needing it.
> 
> So I'll go on a trawl through the source before finalizing the fix,
> but below is the patch you guys need.  Does this patch deal with your
> Bad page states too, Marc?  Does it help your mouse at all somehow?
>

Sorry for the late reply. I was just busy but I'll make the best out of
the sunday morning. :)

After applying the patch the console was quite clean as it used to be.
Thus it seems to work for me as well.

Thanks Hugh,
       Marc
