Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313421AbSG2IfQ>; Mon, 29 Jul 2002 04:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSG2IfQ>; Mon, 29 Jul 2002 04:35:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17930 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313421AbSG2IfO>; Mon, 29 Jul 2002 04:35:14 -0400
Date: Mon, 29 Jul 2002 05:35:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: "David S. Miller" <davem@redhat.com>, <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <Pine.LNX.4.44.0207282256460.872-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0207290527560.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Linus Torvalds wrote:

> And for anonymous pages, I really think that the right solution is to do
> the same remove-from-LRU thing for the "last unmap" (which should be
> trivial to notice with rmap).

Unfortunately it isn't, because the whole thing occurs because
of a race between truncate and the page fault path.  Whatever
check we do, it's still possible for the race to hit us.

This is because vmtruncate walks the mms one by one, so the mms
already passed by vmtruncate can still fault in the not yet
truncated pages from the file.  I've stared at this thing for a
while and didn't come up with a way to prevent this, but maybe
somebody will find it ;)

> Which may imply that Andrew's irq-safe LRU list is the right thing to do
> after all.

According to Andrew it actually increases performance so it
doesn't seem as bad as it sounds.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

