Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319356AbSIFTks>; Fri, 6 Sep 2002 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319358AbSIFTks>; Fri, 6 Sep 2002 15:40:48 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:6641 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319356AbSIFTkq>;
	Fri, 6 Sep 2002 15:40:46 -0400
Message-ID: <1031341500.3d7905bce1a63@imap.linux.ibm.com>
Date: Fri,  6 Sep 2002 12:45:00 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78E7A5.7050306@us.ibm.com> <20020906202646.A2185@wotan.suse.de> <1031339954.3d78ffb257d22@imap.linux.ibm.com> <20020906.122118.52140394.davem@redhat.com>
In-Reply-To: <20020906.122118.52140394.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 9.47.18.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "David S. Miller" <davem@redhat.com>:

> There are methods to eliminate the centrality of the
> port allocation locking.
> 
> Basically, kill tcp_portalloc_lock and make the port rover be
> per-cpu.

Aha! Exactly what I started to do quite a while ago..

> The only tricky case is the "out of ports" situation.  Because
> there is no centralized locking being used to serialize port
> allocation, it is difficult to be sure that the port space is truly
> exhausted.

I decided to use a stupid global flag to signal this..It did become
messy and I didnt finalize everything. Then my day job 
intervened :). Still hoping for spare time*5 to complete
this if none comes up with something before then..

> Another idea, which doesn't eliminate the tcp_portalloc_lock but
> has other good SMP properties, is to apply a "cpu salt" to the
> port rover value.  For example, shift the local cpu number into
> the upper parts of a 'u16', then 'xor' that with tcp_port_rover.

nice..any patch extant? :)

thanks,
Nivedita




