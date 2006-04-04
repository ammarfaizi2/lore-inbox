Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbWDDCfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWDDCfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWDDCfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:35:03 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:30673 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964970AbWDDCfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:35:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] lowmem_reserve question
Date: Tue, 4 Apr 2006 12:35:59 +1000
User-Agent: KMail/1.8.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
References: <200604021401.13331.kernel@kolivas.org> <442F9E91.1020306@yahoo.com.au> <200604031248.13532.kernel@kolivas.org>
In-Reply-To: <200604031248.13532.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604041235.59876.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 12:48 pm, Con Kolivas wrote:
> While trying to digest just what the lowmem_reserve does 
> and how it's utilised I looked at some of the numbers
>
> int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1] = { 256, 256, 32 };
>
> lower_zone->lowmem_reserve[j] = present_pages /
> sysctl_lowmem_reserve_ratio[idx];
>
> This is interesting because there are no bounds on this value and it seems
> possible to set the sysctl to have a lowmem_reserve that is larger than the
> zone size. Ok that's a sysctl so if a user is setting it wrongly that's
> their fault... or should there be some upper bound?
>
> Furthermore, now that we have the option of up to 3GB lowmem split on 32bit
> we can have a default lowmem_reserve of almost 12MB (if I'm reading it
> right) which seems very tight with only 16MB of ZONE_DMA.
>
> On a basically idle 1GB lowmem box that I have it looks like this:
>
> Node 0, zone      DMA
>   pages free     1025
>         min      15
>         low      18
>         high     22
>         active   2185
>         inactive 0
>         scanned  555 (a: 21 i: 6)
>         spanned  4096
>         present  4096
>         protection: (0, 0, 1007, 1007)
>
> With 3GB lowmem the default settings seem too tight to me. The way I see
> it, there should be some upper bounds on the lowmem reserves. Or perhaps
> I'm just missing something again... I'm feeling even thicker than usual.

Silence. Low priority I guess.

If I propose a patch that might get some response. /me threatens to post a 
patch.

Cheers,
Con
