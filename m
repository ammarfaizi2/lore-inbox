Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSACN3Y>; Thu, 3 Jan 2002 08:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287276AbSACN3P>; Thu, 3 Jan 2002 08:29:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10758 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287283AbSACN3E>;
	Thu, 3 Jan 2002 08:29:04 -0500
Date: Thu, 3 Jan 2002 11:28:45 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Harald Holzer <harald.holzer@eunet.at>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
In-Reply-To: <1010015450.15492.19.camel@hh2.hhhome.at>
Message-ID: <Pine.LNX.4.33L.0201031106590.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2002, Harald Holzer wrote:

> at 1GB ram, are 16,936kB low mem reserved.
> 4GB ram, 72,824kB reserved
> 8GB ram, 142,332kB reserved
> 16GB ram, 269,424kB reserved
> 32GB ram, 532,080kB reserved, usable low mem: 352 MB
> 64GB ram ??
>
> Which function does the reserved memory fulfill ?
> Is it all for paging ?

The kernel stores various data structures there, in particular
the mem_map[] array, which has one data structure for each
page.

In the standard kernel, that is 52 bytes per page, giving you
a space usage of 416 MB for the mem_map[] array.

I'm currently integrating a patch into my VM tree which removes
the wait queue from the page struct, bringing the size down to
36 bytes per page, or 288 MB, giving a space saving of 128 MB.

Another item to look into is removing the page cache hash table
and replacing it by a radix tree or hash trie, in the hopes of
improving scalability while at the same time saving some space.

As for page table overhead, on machines like yours we really
should be using 4 MB pages for the larger data segments, which
will cut down the page table size by a factor of 512 ;)

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

