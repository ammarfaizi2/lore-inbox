Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293637AbSCERg4>; Tue, 5 Mar 2002 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293644AbSCERgj>; Tue, 5 Mar 2002 12:36:39 -0500
Received: from rj.sgi.com ([204.94.215.100]:39127 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293637AbSCERgd>;
	Tue, 5 Mar 2002 12:36:33 -0500
Date: Tue, 5 Mar 2002 09:35:42 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: <andrea@suse.de>, <Martin.Bligh@us.ibm.com>, <riel@conectiva.com.br>,
        <phillips@bonn-fries.net>, <davidsen@tmr.com>, <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305122323.0ed9a343.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0203050929040.14769-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Stephan von Krawczynski wrote:

> On Mon, 4 Mar 2002 15:03:19 -0800 (PST)
> Samuel Ortiz <sortiz@dbear.engr.sgi.com> wrote:
>
> > On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> > > yes, also make sure to keep this patch from SGI applied, it's very
> > > important to avoid memory balancing if there's still free memory in the
> > > other zones:
> > >
> > > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/20_numa-mm-1
> > This patch is included (in a slightly different form) in the 2.4.17
> > discontig patch (http://sourceforge.net/projects/discontig).
> > But martin may need another patch to apply. With the current
> > implementation of __alloc_pages, we have 2 problems :
> > 1) A node is not emptied before moving to the following node
> > 2) If none of the zones on a node have more freepages than min(defined as
> >    min+= z->pages_low), we start looking on the following node, instead of
> >    trying harder on the same node.
>
> Forgive my ignorance, but aren't these two problems completely identical in a
> UP or even SMP setup? I mean what is the negative drawback in your proposed
> solution, if there simply is no other node? If it is not harmful to the
> "standard" setups it may as well be included in the mainline, or not?
You're right. It is harmful to the standard UMA boxes. However, the
current __alloc_pages does just what it is supposed to do on those boxes.
That's why very few people have been bothered by this bug. I was just
waiting for Andrea or Rik's feedback before trying to push it to Marcelo.
Maybe they'll find some time to review the patch soon...

Cheers,
Samuel.



