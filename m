Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314625AbSEMXZ6>; Mon, 13 May 2002 19:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314681AbSEMXZ5>; Mon, 13 May 2002 19:25:57 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:5644 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314625AbSEMXZ4>; Mon, 13 May 2002 19:25:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Rusty Russell <rusty@rustcorp.com.au>,
        engebret@vnet.ibm.com, justincarlson@cmu.edu, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, anton@samba.org, ak@suse.de,
        paulus@samba.org
Subject: Re: Memory Barrier Definitions 
In-Reply-To: Your message of "Mon, 13 May 2002 09:50:01 MST."
             <Pine.LNX.4.44.0205130938380.19524-100000@home.transmeta.com> 
Date: Tue, 14 May 2002 09:28:19 +1000
Message-Id: <E177PEp-0001Hm-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205130938380.19524-100000@home.transmeta.com> you wr
ite:
> We're _not_ going to make up a complicated, big fancy new model. We might
> tweak the current one a bit. And if that means that some architectures get
> heavier barriers than they strictly need, then so be it. There are two
> overriding concerns:
> 
>  - sanity: maybe it's better to have one mb() that is a sledgehammer but
>    obvious, than it is to have many subtle variations that are just asking
>    for subtle bugs.

NO NO NO.  Look at what actually happens now:

	void init_bh(int nr, void (*routine)(void))
	{
		bh_base[nr] = routine;
		mb();
	}

Now, what is this mb() for?  Are you sure?

If we can come up with a better fit between the macros and what the
code are trying to actually do, we win, even if they all map to the
same thing *today*.  While we're there, if we can get something that
fits with different architectures, great.

Clearer?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
