Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSE1Qeb>; Tue, 28 May 2002 12:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316843AbSE1Qea>; Tue, 28 May 2002 12:34:30 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:11670 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316842AbSE1Qe3>; Tue, 28 May 2002 12:34:29 -0400
Date: Tue, 28 May 2002 18:34:09 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com, andrea@suse.de
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
Message-ID: <20020528183409.A23001@averell>
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <20020528.054043.06045639.davem@redhat.com> <m3bsb06zt7.fsf@averell.firstfloor.org> <1022605393.9255.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 07:03:13PM +0200, Alan Cox wrote:
> On Tue, 2002-05-28 at 16:45, Andi Kleen wrote: 
> > The next obvious benefitor IMHO is module unloading. Just putting 
> > a synchronize_kernel() somewhere at the end of sys_delete_modules()
> > after the destructor makes module unloading much less nasty than it 
> > used to be (yes it doesn't fix all possible module unload races, but a 
> > large share of them and it makes the problem much more controllable) 
> 
> For 2.5 it would be much more productive to make sys_delete_module
> memset the entire vmalloced space of the module to an illegal
> instruction before returning

And gain tons of new atomic_incs and decs everywhere in the process?  
I would prefer RCU. 

-Andi
