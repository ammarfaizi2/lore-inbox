Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262613AbRFKSKM>; Mon, 11 Jun 2001 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbRFKSKC>; Mon, 11 Jun 2001 14:10:02 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:64776 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S262613AbRFKSJv>; Mon, 11 Jun 2001 14:09:51 -0400
Date: Mon, 11 Jun 2001 12:11:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Lauri Tischler <lauri.tischler@efore.fi>, linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: IPX to Netware 5.1
Message-ID: <20010611121159.A16917@vger.timpanogas.org>
In-Reply-To: <3B24BE9F.AA4C8CCB@efore.fi> <20010611121519.D2145@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010611121519.D2145@conectiva.com.br>; from acme@conectiva.com.br on Mon, Jun 11, 2001 at 12:15:19PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 12:15:19PM -0300, Arnaldo Carvalho de Melo wrote:


The problem is related to the default NLSP (NetWare Link State Routing)
stack loaded by default on NetWare versions 5.1 >.  NLSP doesn't send 
RIP/SAP all the time, and if ipx_configure is set to --auto-interface=on
--auto-primary=on, the ipx client in Linux will not set it's IPX 
address until it sees some traffic.  This is usually a problem in 
setups with only one server on the entire network, since the server
won't RIP/SAP right away.  

Simply go to the NetWare 5.X server, and type at the console

:
:reset router
:

and this should cause the 5.1 server to send an old-style RIP/SAP frame
which will then kick on all the Linux systems.  You will notice that each 
time you turn off your linux machine, you will have to type this on the 
NetWare 5.x server console in order to get the server to kick out a 
RIP/SAP frame and allow the Linux box to auto-detect the network address.
One way around this is to hard set the network address via ipx_configure
and the problem is less troublesome.

Jeff  








> Em Mon, Jun 11, 2001 at 03:50:39PM +0300, Lauri Tischler escreveu:
> > I've been mounting Netware volumes from Netware 4.1x to linux for
> > a quite a while now, works just fine.
> > We installed new Netware server with Netware 5.1 and I can't now
> > mount any volumes.  The error message is:
> >   ncpmount: Unknown Server error (0x8901) in nds login
> >   Login denied.
> > The error is same if I try bindery login.
> > Any IPX gurus here or hints or links about ??
> 
> See if this makes sense:
> 
> http://developer.novell.com/support/sample/tids/bs98au6h/nwerrors.txt
> 
> #define ERR_INSUFFICIENT_SPACE          0x8901  /* 001 */
> #define NWE_INSUFFICIENT_SPACE          0x8901  /* 001 */
> 
> And can you, just in case, check if IPX is enabled? ncpfs can work with
> tcp/ip as well and this can possibly be not related to IPX
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
