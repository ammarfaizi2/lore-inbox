Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288664AbSATPOZ>; Sun, 20 Jan 2002 10:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288677AbSATPOP>; Sun, 20 Jan 2002 10:14:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:47620 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288664AbSATPOH>;
	Sun, 20 Jan 2002 10:14:07 -0500
Date: Sun, 20 Jan 2002 13:13:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Shawn <spstarr@sh0n.net>, <linux-kernel@vger.kernel.org>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4AD24D.4050206@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201201229100.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2002, Hans Reiser wrote:

> Write clustering is one thing it achieves.
>
> Flushing everything involved in a transaction ... is another thing.

Agreed on these points, but you really HAVE TO work towards
flushing the page ->writepage() gets called for.

Think about your typical PC, with memory in ZONE_DMA,
ZONE_NORMAL and ZONE_HIGHMEM. If we are short on DMA pages
we will end up calling ->writepage() on a DMA page.

If the filesystem ends up writing completely unrelated pages
and marking the DMA page in question referenced the VM will
go in a loop until the filesystem finally gets around to
making a page in the (small) DMA zone freeable ...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

