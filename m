Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVLQFdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVLQFdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 00:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbVLQFdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 00:33:20 -0500
Received: from pat.uio.no ([129.240.130.16]:2267 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750949AbVLQFdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 00:33:19 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051216235841.GA20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
	 <1134776945.7952.4.camel@lade.trondhjem.org>
	 <20051216235841.GA20539@tau.solarneutrino.net>
Content-Type: text/plain
Date: Sat, 17 Dec 2005 00:32:57 -0500
Message-Id: <1134797577.20929.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.033, required 12,
	autolearn=disabled, AWL 1.78, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 18:58 -0500, Ryan Richter wrote:
> On Fri, Dec 16, 2005 at 06:49:05PM -0500, Trond Myklebust wrote:
> > On Fri, 2005-12-16 at 15:55 -0500, Ryan Richter wrote:
> > > Hi, nfs locking stopped working on my file server running 2.6.15-rc5
> > > today.  All clients that try locking operations hang, and I get the
> > > message from the server:
> > > 
> > > lockd: couldn't create RPC handle for w.x.y.z
> > 
> > Points either to a client which is not responding to callbacks, or an
> > OOM situation on the server.
> > 
> > Does 'rpcinfo -u w.x.y.z 100021' work from the server?
> 
> No.
> 
> $ rpcinfo -u jacquere 100021
> rpcinfo: RPC: Timed out
> program 100021 version 0 is not available
> zsh: exit 1     rpcinfo -u jacquere 100021
> 
> So I see now lockd is not present on the client. But...
> 
> $ rpcinfo -p jacquere
>    program vers proto   port
>     100000    2   tcp    111  portmapper
>     100000    2   udp    111  portmapper
>     100021    1   udp  32768  nlockmgr
>     100021    3   udp  32768  nlockmgr
>     100021    4   udp  32768  nlockmgr
>     100024    1   udp    867  status
>     100024    1   tcp    870  status
> 
> So what does that mean?

Looks to me as if port 111 is pingable (since you can talk to the
portmapper), but port 32768 is not. Are you using port filtering or
firewalling anywhere (on the client, server, or switches)?

Cheers,
  Trond

