Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316834AbSE1QBE>; Tue, 28 May 2002 12:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSE1QBE>; Tue, 28 May 2002 12:01:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55547 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316834AbSE1QBD>; Tue, 28 May 2002 12:01:03 -0400
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, paul.mckenney@us.ibm.com, andrea@suse.de
In-Reply-To: <m3bsb06zt7.fsf@averell.firstfloor.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 18:03:13 +0100
Message-Id: <1022605393.9255.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 16:45, Andi Kleen wrote: 
> The next obvious benefitor IMHO is module unloading. Just putting 
> a synchronize_kernel() somewhere at the end of sys_delete_modules()
> after the destructor makes module unloading much less nasty than it 
> used to be (yes it doesn't fix all possible module unload races, but a 
> large share of them and it makes the problem much more controllable) 

For 2.5 it would be much more productive to make sys_delete_module
memset the entire vmalloced space of the module to an illegal
instruction before returning

