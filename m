Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314128AbSEMQuQ>; Mon, 13 May 2002 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314282AbSEMQuP>; Mon, 13 May 2002 12:50:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314128AbSEMQuO>; Mon, 13 May 2002 12:50:14 -0400
Date: Mon, 13 May 2002 09:50:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: Rusty Russell <rusty@rustcorp.com.au>, <engebret@vnet.ibm.com>,
        <justincarlson@cmu.edu>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <anton@samba.org>, <ak@suse.de>,
        <paulus@samba.org>
Subject: Re: Memory Barrier Definitions
In-Reply-To: <15583.60301.410541.204804@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0205130938380.19524-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 May 2002, David Mosberger wrote:
>
>  This would have to be complemented by a set of barrier routines which
> will achieve the desired ordering on machines that don't have the
> acquire/release model of ia64 (and on ia64, they would expand into
> nothing).

Earth to ia64, earth calling...

Until ia64 is a noticeable portion of the installed base, and indeed,
until it has shown that it can survive at all, we're not going to design
the Linux SMP memory ordering around that architecture.

If that means that ia64 will have to do strange things and maybe cannot
take advantage of its strange memory models, that's ok. Because reality
rules.

We're _not_ going to make up a complicated, big fancy new model. We might
tweak the current one a bit. And if that means that some architectures get
heavier barriers than they strictly need, then so be it. There are two
overriding concerns:

 - sanity: maybe it's better to have one mb() that is a sledgehammer but
   obvious, than it is to have many subtle variations that are just asking
   for subtle bugs.

 - x86 _owns_ the market right now, and we're not going to make up
   barriers that add overhead to x86. We may add barriers that end up
   being no-op's on x86 (because it is fairly ordered anyway), but
   basically it should be designed for the _common_ case, not for some
   odd-ball architecture that has sold machines mostly for test purposes.

The x86 situation is obviously just today. In five or ten years maybe
everybody agrees that we should follow the ia-64 model, and x86 can do
strange things that end up being slow.

			Linus

