Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSF1Kg2>; Fri, 28 Jun 2002 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317110AbSF1Kg1>; Fri, 28 Jun 2002 06:36:27 -0400
Received: from pat.uio.no ([129.240.130.16]:46293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S317107AbSF1Kg1>;
	Fri, 28 Jun 2002 06:36:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: kuznet@ms2.inr.ac.ru
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Fri, 28 Jun 2002 12:38:39 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200206272207.CAA16913@sex.inr.ac.ru> <200206281022.51074.trond.myklebust@fys.uio.no>
In-Reply-To: <200206281022.51074.trond.myklebust@fys.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206281238.40242.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 June 2002 10:22, Trond Myklebust wrote:

> > Repeating the third time in hope you eventually read the mail to the end:
> > >>>Better way exists. Just use forced sock_wmalloc instead of
> > >>>sock_alloc_send_skb on non-blocking send of all the fragments
> > >>>but the first.
> Attached is a patch that I hope you will comment on (without too many
> expletives please ;-))...

After fixing the missing brackets around (flags&MSG_DONTWAIT), I did some 
tests. I did some NFS writes to a Solaris server, write size = 32k, UDP, over 
a switched 100Mbit/s network. Tests were done using the iozone program (see 
http://www.iozone.org) 'iozone -c -e -t1 -s 120m -r128k'

 - With an ordinary kernel without the patch, I saw average write speeds of 
~2MB/s (peaking at ~2.5MB/s in one trial).

 - With the same kernel, but applying the sock_wmalloc() patch, write speeds 
suddenly jump to ~4.5MB/s (peak was 5MB/s).

... and yes, I did reboot several times in order to switch between the 2 
kernels in order to check repeatability.

I did not expect the effect to be so large, and certainly I can't explain it, 
however I hope you agree that it shows that fixing this bug *is* worth the 
effort.

Cheers,
  Trond
