Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVLSSvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLSSvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLSSvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:51:16 -0500
Received: from dcs.nac.uci.edu ([128.200.34.32]:40392 "EHLO dcs.nac.uci.edu")
	by vger.kernel.org with ESMTP id S932352AbVLSSvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:51:15 -0500
Subject: Re: [NFS] Re: lockd: couldn't create RPC handle for (host)
From: Dan Stromberg <strombrg@dcs.nac.uci.edu>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, strombrg@dcs.nac.uci.edu
In-Reply-To: <20051217055907.GC20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
	 <1134776945.7952.4.camel@lade.trondhjem.org>
	 <20051216235841.GA20539@tau.solarneutrino.net>
	 <1134797577.20929.2.camel@lade.trondhjem.org>
	 <20051217055907.GC20539@tau.solarneutrino.net>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 10:49:44 -0800
Message-Id: <1135018184.1122.168.camel@seki.nac.uci.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sometimes what'll happen is that the daemon (or kernel component) that
services requests on an RPC port will die or otherwise stop servicing
requests, but I believe there's nothing in the portmapper or rpcbind
daemon(s) that will periodically poll to see if those requests are still
being serviced.

I'd hop over to another machine that is advertising the same service,
and use this URL:

http://dcs.nac.uci.edu/~strombrg/What-program-is-active-on-that-port.html

...to see what -should- be handling those requests, and then check on
that same facility on the host having trouble.

On Sat, 2005-12-17 at 00:59 -0500, Ryan Richter wrote:
> On Sat, Dec 17, 2005 at 12:32:57AM -0500, Trond Myklebust wrote:
> > On Fri, 2005-12-16 at 18:58 -0500, Ryan Richter wrote:
> > > On Fri, Dec 16, 2005 at 06:49:05PM -0500, Trond Myklebust wrote:
> > > > On Fri, 2005-12-16 at 15:55 -0500, Ryan Richter wrote:
> > > > > Hi, nfs locking stopped working on my file server running 2.6.15-rc5
> > > > > today.  All clients that try locking operations hang, and I get the
> > > > > message from the server:
> > > > > 
> > > > > lockd: couldn't create RPC handle for w.x.y.z
> > > > 
> > > > Points either to a client which is not responding to callbacks, or an
> > > > OOM situation on the server.
> > > > 
> > > > Does 'rpcinfo -u w.x.y.z 100021' work from the server?
> > > 
> > > No.
> > > 
> > > $ rpcinfo -u jacquere 100021
> > > rpcinfo: RPC: Timed out
> > > program 100021 version 0 is not available
> > > zsh: exit 1     rpcinfo -u jacquere 100021
> > > 
> > > So I see now lockd is not present on the client. But...
> > > 
> > > $ rpcinfo -p jacquere
> > >    program vers proto   port
> > >     100000    2   tcp    111  portmapper
> > >     100000    2   udp    111  portmapper
> > >     100021    1   udp  32768  nlockmgr
> > >     100021    3   udp  32768  nlockmgr
> > >     100021    4   udp  32768  nlockmgr
> > >     100024    1   udp    867  status
> > >     100024    1   tcp    870  status
> > > 
> > > So what does that mean?
> > 
> > Looks to me as if port 111 is pingable (since you can talk to the
> > portmapper), but port 32768 is not. Are you using port filtering or
> > firewalling anywhere (on the client, server, or switches)?
> 
> There's no filtering between the two.  I get this on the machine itself:
> $ rpcinfo -u localhost 100021
> rpcinfo: RPC: Timed out
> program 100021 version 0 is not available
> zsh: exit 1     rpcinfo -u localhost 100021
> 
> There's no lockd process running on this client machine anymore.
> 
> On the server:
> 
> $ rpcinfo -u localhost 100021               
> program 100021 version 1 ready and waiting
> rpcinfo: RPC: Program/version mismatch; low version = 1, high version =4
> program 100021 version 2 is not available
> program 100021 version 3 ready and waiting
> program 100021 version 4 ready and waiting
> zsh: exit 1     rpcinfo -u localhost 100021
> 
> Also neither machine is anywhere close to OOM.
> 
> -ryan
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs
> 

