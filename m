Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319195AbSH2Mdu>; Thu, 29 Aug 2002 08:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319197AbSH2Mdt>; Thu, 29 Aug 2002 08:33:49 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:61616 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319195AbSH2Mdt>; Thu, 29 Aug 2002 08:33:49 -0400
Date: Thu, 29 Aug 2002 09:37:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
In-Reply-To: <20020829034957.GE878@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0208290933200.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2002, William Lee Irwin III wrote:

> +	gfp_nowait = gfp_mask & ~(__GFP_WAIT | __GFP_IO | __GFP_NOKILL);


I suspect what you want is (in vmscan.c):

-	out_of_memory();
+	if (gfp_mask & __GFP_FS)
+		out_of_memory();

This means we'll just never call out_of_memory() if we haven't
used all possibilities for freeing pages.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

