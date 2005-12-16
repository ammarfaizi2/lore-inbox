Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVLPX6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVLPX6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLPX6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:58:47 -0500
Received: from solarneutrino.net ([66.199.224.43]:55302 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751351AbVLPX6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:58:46 -0500
Date: Fri, 16 Dec 2005 18:58:42 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20051216235841.GA20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net> <1134776945.7952.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134776945.7952.4.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 06:49:05PM -0500, Trond Myklebust wrote:
> On Fri, 2005-12-16 at 15:55 -0500, Ryan Richter wrote:
> > Hi, nfs locking stopped working on my file server running 2.6.15-rc5
> > today.  All clients that try locking operations hang, and I get the
> > message from the server:
> > 
> > lockd: couldn't create RPC handle for w.x.y.z
> 
> Points either to a client which is not responding to callbacks, or an
> OOM situation on the server.
> 
> Does 'rpcinfo -u w.x.y.z 100021' work from the server?

No.

$ rpcinfo -u jacquere 100021
rpcinfo: RPC: Timed out
program 100021 version 0 is not available
zsh: exit 1     rpcinfo -u jacquere 100021

So I see now lockd is not present on the client. But...

$ rpcinfo -p jacquere
   program vers proto   port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100021    4   udp  32768  nlockmgr
    100024    1   udp    867  status
    100024    1   tcp    870  status

So what does that mean?

> > Also, the lockd process is unkillable, it looks like I'll have to
> > reboot.
> 
> lockd cannot be killed as long as you have active nfsd threads or active
> nfs client partitions. That is by design.

OK, that's good to know.

Thanks,
-ryan
