Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTJERSv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJERSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:18:51 -0400
Received: from intra.cyclades.com ([64.186.161.6]:32646 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263203AbTJERSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:18:48 -0400
Date: Sun, 5 Oct 2003 14:21:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andi Kleen <ak@colin2.muc.de>
Cc: Tony Hoyle <tmh@nodomain.org>, Andi Kleen <ak@muc.de>,
       <linux-kernel@vger.kernel.org>, <marcelo.tosatti@cyclades.com.br>
Subject: Re: Oops linux 2.4.23-pre6 on amd64
In-Reply-To: <20031005153707.GB30792@colin2.muc.de>
Message-ID: <Pine.LNX.4.44.0310051420110.1408-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 Oct 2003, Andi Kleen wrote:

> On Sun, Oct 05, 2003 at 03:29:38PM +0100, Tony Hoyle wrote:
> > Andi Kleen wrote:
> > 
> > >To rule out the compiler you can use the compiler/binutils from
> > >
> > >ftp.suse.com:/pub/suse/x86-64/supplementary/CrossTools/8.1-i386/
> > >
> > OK I built with that and here are the results:
> > 
> > 1. The ehci-hcd driver fails in exactly the same place.
> > 2. It was still v. unstable, which led me to investigate why (since I'm 
> > pretty sure the hardware is good & the suse compiler is supposed to be a 
> > good one).  I started stripping out options until eventually I found 
> > that it's devfs that's the culprit - with that enabled I get random 
> > compile errors every few seconds.  With it disabled the compile works 
> > perfectly, even with the debian compiler (tried -j20 and -j255 and both 
> > passed).
> 
> Thanks for tracking this down. I would have never noticed
> because I don't use devfs.
> 
> Marcelo, any ideas? Do you get broken devfs reports for other
> 64bit architectures too?

Nope, never got such reports. 

What problem are you seeing Tony? Oopsing right? Where is the oops output?

> AFAIK devfs is unmaintained and I don't really plan to maintain
> it myself. My proposal is to just disable it in the configuration
> for x86-64 for now.

Nod

> 
> > My first guess was you can't use a 32bit devfsd with a 64bit kernel, but 
> > stopping devfsd didn't seem to make a whole lot of difference to the 
> > stability... only compiling out the entire devfs system solved it.
> 
> Very likely the devfs code in the kernel is buggy. It is known
> to be race hell, I wouldn't be surprised if it has 64bit bugs too.

Yes.

