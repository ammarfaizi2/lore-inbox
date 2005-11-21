Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVKURJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVKURJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKURJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:09:06 -0500
Received: from silver.veritas.com ([143.127.12.111]:60000 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932351AbVKURJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:09:04 -0500
Date: Mon, 21 Nov 2005 17:09:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Takashi Iwai <tiwai@suse.de>
cc: Lee Revell <rlrevell@joe-job.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: 2.6.15-rc1-mm2 -- Bad page state at free_hot_cold_page (in
 process 'aplay', page c18eef30)
In-Reply-To: <s5h8xvinfg7.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.61.0511211651270.16632@goblin.wat.veritas.com>
References: <a44ae5cd0511192256u20f0e594kc65cbaba108ff06e@mail.gmail.com>
 <Pine.LNX.4.61.0511200804500.3938@goblin.wat.veritas.com>
 <1132510467.6874.144.camel@mindpipe> <Pine.LNX.4.61.0511201915530.8619@goblin.wat.veritas.com>
 <s5hlkzinrq5.wl%tiwai@suse.de> <Pine.LNX.4.61.0511211507160.15988@goblin.wat.veritas.com>
 <s5h8xvinfg7.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 17:09:04.0407 (UTC) FILETIME=[46825270:01C5EEBE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Takashi Iwai wrote:
> 
> Now another question arises:  Which is the recommended method for
> mmapping RAM pages, vma nopage callback or remap_pfn_range()?
> 
> IIRC, in the ealier versions, the former was recommended because
> remap_page_range() with page-reserve was regarded as a hack.

I do believe Linus (CC'ed so he can defend himself from my slanders)
saw it that way for a long while.  I believe he did, and still does,
think it more correct to work through the intended vm_operations_struct
methods.  But has relented a little down the years, and now accepts
that remap_pfn_range is here to stay (as much as anything stays).

> But, looking through these changes, I feel that remap_pfn_range() is
> better (easier and stabler) than vma nopage...

I'm not going to make a recommendation: whatever suits you best.

It does sometimes look like people converted from remap_pfn_range
to nopage, just because they felt under pressure to do so.

It is curious that your snd_pcm_mmap_status_nopage seems to have been
affected and nothing else (I'd expected trouble in DRM but no sign).

I've CC'ed hch also, he did have some pungent views on how you ought
better to go about this.

Hugh
