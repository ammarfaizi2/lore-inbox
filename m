Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRBZS3L>; Mon, 26 Feb 2001 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRBZS3A>; Mon, 26 Feb 2001 13:29:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1290 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129583AbRBZS2r>; Mon, 26 Feb 2001 13:28:47 -0500
Date: Mon, 26 Feb 2001 13:42:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Mordechai T. Abzug" <morty@sanctuary.arbutus.md.us>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cache/swap issues under 2.4.1, 2.4.2
In-Reply-To: <20010226033713.A7120@red-sonja.sanctuary.arbutus.md.us>
Message-ID: <Pine.LNX.4.21.0102261136310.5626-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Feb 2001, Mordechai T. Abzug wrote:

> Why do I have 47MB of swap in use?  I thought at first that it might
> be due to the minimum allowable cache size, but considering that there
> was only 48MB of RAM in use to begin with, that still seems
> suspicious.  Even weirder, if I then turn off swap, the usage looks
> more reasonable:
> 
> # swapoff -a
> 
> # free
>              total       used       free     shared    buffers     cached
> Mem:        255564      53900     201664          0        840       9356
> -/+ buffers/cache:      43704     211860
> Swap:            0          0          0

The "used" swap space here means _allocated_ swap space, not necessarily
used swap space. 

Linux 2.4 allocate's swap space for an anonymous page when it unmaps a
page table entry mapping the page. When it allocates the swap space, it
also adds the page to the swapcache to be written later. 

The swapcache is part of the pagecache. The swapoff rips all the
swapcached pages on the device, thats why you see a lot less memory
"cached" after the swapoff. 





