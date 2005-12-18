Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVLRIfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVLRIfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 03:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVLRIfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 03:35:05 -0500
Received: from pat.uio.no ([129.240.130.16]:30963 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932395AbVLRIfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 03:35:04 -0500
Subject: Re: lockd: couldn't create RPC handle for (host)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20051217194553.GE20539@tau.solarneutrino.net>
References: <20051216205536.GA20497@tau.solarneutrino.net>
	 <1134776945.7952.4.camel@lade.trondhjem.org>
	 <20051216235841.GA20539@tau.solarneutrino.net>
	 <1134797577.20929.2.camel@lade.trondhjem.org>
	 <20051217055907.GC20539@tau.solarneutrino.net>
	 <1134801822.7946.4.camel@lade.trondhjem.org>
	 <20051217070222.GD20539@tau.solarneutrino.net>
	 <1134847699.7950.25.camel@lade.trondhjem.org>
	 <20051217194553.GE20539@tau.solarneutrino.net>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 03:33:56 -0500
Message-Id: <1134894836.7931.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.236, required 12,
	autolearn=disabled, AWL 1.63, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-17 at 14:45 -0500, Ryan Richter wrote:
> > So what do you mean when you say that there is "no lockd process
> > running" on the client?
> > 
> > Is it not appearing in the output of 'ps -ef' either?
> 
> Nope.
> 
> $ ps -ef|grep lock
> root        77     5  0 Nov20 ?        00:00:00 [kblockd/0]
> foo       6811  6800  0 14:29 pts/0    00:00:00 grep -E lock

Any Oopses? (use 'dmesg')

Could you also check dmesg for any entries of the form

'lockd: new process, skipping host shutdown'
or
'lockd_up: makesock failed, error='

> > Is anything at all listening on port 32768 on 'jacquere'? (check using
> > 'netstat -ap | grep 32768').
> 
> Er... sort of?
> 
> # netstat -ap | grep 32768
> udp    11144      0 *:32768                 *:*                                -                   
> I'm not sure what that means...  lsof|grep 32768 returns nothing.

That could be a kernel process. The RPC client has no reason to set up a
full file descriptor for the socket.

Could you please finally double-check that the entries in /proc/mounts
for your NFS mounts do contain the 'lock' mount option.

Finally, please do

echo 1 > /proc/sys/sunrpc/rpc_lockd
then unmount one of your NFS partitions, and then mount it again.


Cheers,
  Trond

