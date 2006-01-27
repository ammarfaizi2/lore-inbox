Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWA0PqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWA0PqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWA0PqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:46:07 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:7896 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751486AbWA0PqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:46:07 -0500
Date: Sat, 28 Jan 2006 00:45:40 +0900 (JST)
Message-Id: <20060128.004540.59467062.anemo@mba.ocn.ne.jp>
To: hugh@veritas.com
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, tbm@cyrius.com,
       t.sailer@alumni.ethz.ch, perex@suse.cz, ralf@linux-mips.org
Subject: Re: ALSA on MIPS platform
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com>
	<s5hzmljt1si.wl%tiwai@suse.de>
References: <20060127.002925.25911749.anemo@mba.ocn.ne.jp>
	<s5hzmljt1si.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0601261910230.15596@goblin.wat.veritas.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 26 Jan 2006 19:19:22 +0000 (GMT), Hugh Dickins <hugh@veritas.com> said:

>> Well, the whole page-reserve kludge should disappear anyway in near
>> future.  Right now it's in the process.

hugh> Yes, mark_pages() and unmark_pages() can just be removed as soon
hugh> as you like.

When I tried undefining NEED_RESERVE_PAGES for MIPS on 2.6.13,
something did not work (I can not remember details...).  But it seems
things have been changed in 2.6.15.  I'll try again.  Thanks.

hugh> I didn't reply to the original posting because I noticed they're
hugh> not all of the virt_to_page()s in sound/core, and sometimes a
hugh> part-answer distracts someone more competent from responding
hugh> with the full answer.

Yes, there is still virt_to_page() in snd_pcm_mmap_data_nopage() and
snd_malloc_sgbuf_pages().  If dma_mmap_coherent() was ported, former
might disappear but latter might not.  So it seems virt_to_page()
issue still remains...

>>>>> On Thu, 26 Jan 2006 17:02:53 +0100, Takashi Iwai <tiwai@suse.de> said:

tiwai> The memory allocation stuff in ALSA is being largely rewritten
tiwai> on my local tree, but it's not released yet.  One reason is to
tiwai> wait for the finish of page-reserve removals, and another
tiwai> reason is that I've had little time to tidy them up :)

OK, I'll wait.  Thank you very much.

---
Atsushi Nemoto
