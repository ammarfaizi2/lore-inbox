Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262013AbTCRAAE>; Mon, 17 Mar 2003 19:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbTCRAAE>; Mon, 17 Mar 2003 19:00:04 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:31981 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S262013AbTCRAAD>;
	Mon, 17 Mar 2003 19:00:03 -0500
From: wind@cocodriloo.com
Date: Tue, 18 Mar 2003 01:12:10 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: wind@cocodriloo.com, bzzz@tmi.comex.ru, riel@surriel.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030318001210.GH11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com> <20030317165223.GA11526@wind.cocodriloo.com> <m3hea2gcoz.fsf@lexa.home.net> <20030317140506.686282a5.akpm@digeo.com> <20030317230839.GG11526@wind.cocodriloo.com> <20030317152855.388b643f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317152855.388b643f.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 03:28:55PM -0800, Andrew Morton wrote:
> wind@cocodriloo.com wrote:
> >
> > > This is all a bit dubious for several reasons.  Most particularly, the
> > > up-front instantiation of the pages in pagetables makes unneeded pages harder
> > > to reclaim.  It would be really neat if someone could try putting the
> > > madvise(MADV_WILLNEED) into glibc and test that.  Maybe on a 2.4 kernel.
> > 
> > 
> > something like this one?
> > 
> 
> No, not at all.  I meant a patch against glibc, not against the kernel!
> 
> Like this:
> 
> 	map = mmap(..., PROT_EXEC, ...);
> +	if (getenv("MAP_PREFAULT"))
> +		madvise(map, length, MADV_WILLNEED);


I know what you mean, but right now it's far easier hacking the
kernel than libc, at least if running a uml-kernel ;)

Anyways, I booted my patch but I don't know if it's working, because
I've got no test machine to try it on... but, it didn't freak out
so I think it works :)))

As for the libc patch, I think it can be easier to make an
exec-prefault.so library and LD_PRELOAD it, at least for testing
purposes.

If you could tell me the locking is right, I might try patching my
physical machine 2.4.19-ck4 with the kernel patch just to see if it
works.
