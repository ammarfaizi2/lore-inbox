Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135198AbRDLPIH>; Thu, 12 Apr 2001 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135199AbRDLPH5>; Thu, 12 Apr 2001 11:07:57 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2319 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135198AbRDLPHw>;
	Thu, 12 Apr 2001 11:07:52 -0400
Date: Thu, 12 Apr 2001 12:07:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.GSO.4.21.0104121044020.19944-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0104121202090.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Alexander Viro wrote:
> On Thu, 12 Apr 2001, Jan Harkes wrote:
> 
> > But the VM pressure on the dcache and icache only comes into play once
> > the system still has a free_shortage _after_ other attempts of freeing
> > up memory in do_try_to_free_pages.
> 
> I don't think that it's necessary bad.

Please take a look at Ed Tomlinson's patch. It also puts pressure
on the dcache and icache independent of VM pressure, but it does
so based on the (lack of) pressure inside the dcache and icache
themselves.

The patch looks simple, sane and it might save us quite a bit of
trouble in making the prune_{icache,dcache} functions both able
to avoid low-memory deadlocks *AND* at the same time able to run
fast under low-memory situations ... we'd just prune from the
icache and dcache as soon as a "large portion" of the cache isn't
in use.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

