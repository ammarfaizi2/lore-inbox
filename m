Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291565AbSBNM0c>; Thu, 14 Feb 2002 07:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBNM0X>; Thu, 14 Feb 2002 07:26:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:5127 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291565AbSBNM0E>; Thu, 14 Feb 2002 07:26:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Feb 2002 12:10:37 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020214121037.A6194@bytesex.org>
In-Reply-To: <Pine.LNX.4.21.0202131652050.20915-100000@freak.distro.conectiva> <Pine.LNX.4.21.0202141045250.1722-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202141045250.1722-100000@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> However: that is the only unambiguous example I've seen, and you
> may argue that his bttv 0.8 driver is not in the current 2.4 tree,
> is experimental, and even wrong in that area (we now know it also
> vfrees there).

I've recently changed the code to make it *not* call unmap_kiobuf/vfree
from irq context.  Instead bttv 0.8.x doesn't allow you to close the
device with DMA xfers in flight.  If you try this the release() fops
handler will block until the transfer is done, then unmap_kiobuf from
process context, then return.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
