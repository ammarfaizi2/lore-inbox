Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263180AbTDBWiJ>; Wed, 2 Apr 2003 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbTDBWiJ>; Wed, 2 Apr 2003 17:38:09 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:14262 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263180AbTDBWiI>; Wed, 2 Apr 2003 17:38:08 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Apr 2003 14:47:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <netdev@oss.sgi.com>
Subject: Re: loopback behaviour under high load ...
In-Reply-To: <1049304194.25168.56.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.50.0304021049510.1758-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0304011826340.1932-100000@blue1.dev.mcafeelabs.com>
  <Pine.LNX.4.50.0304020821250.1758-100000@blue1.dev.mcafeelabs.com>
 <1049304194.25168.56.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Martin Josefsson wrote:

> On Wed, 2003-04-02 at 18:23, Davide Libenzi wrote:
> > On Tue, 1 Apr 2003, Davide Libenzi wrote:
> >
> > > And netstat shows Recv-Q=0 for the server socket, and Send-Q=N for the
> > > client socket. This has been tested on 2.5.66 vanilla.
> >
> > An update on this. Kernel 2.4.20+epoll does not have this problem.
>
> I see something similar with 2.5.64-bk10 (seen with earlier 2.5 kernels
> as well).
>
> I use distcc on my machine which is running 2.5.64-bk10 and using two
> remote servers running 2.4.20 to do the compiling.
>
> Sometimes I see a ~120s stall in the middle of a connection with
> Recv-Q=0 on the server (2.4.20) and Send-Q=N on the client (2.5.64-bk10)
> (it's the client that's sending data to the server)
>
> x.x.x.x = client
> y.y.y.y = server
>
> As you can see there's a long delay between 16:02:09 and 16:04:24
>
> There's some packetloss here (probably a congested interface in the
> router on the way). The dump was made on the client.

Hmm, we don't see any dropped packet at interface ( loopback ) level here:

$ cat /proc/net/softnet_stat
002a0c14 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000

$ ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1349417 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1349417 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0




- Davide

