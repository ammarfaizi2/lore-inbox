Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbUKWXnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbUKWXnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbUKWXmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:42:12 -0500
Received: from smtp09.auna.com ([62.81.186.19]:5555 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261631AbUKWXjA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:39:00 -0500
Date: Tue, 23 Nov 2004 22:31:43 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <419A9151.2000508@atmos.washington.edu>
	<20041116163257.0e63031d@zqx3.pdx.osdl.net>
	<cone.1100651833.776334.15267.502@pc.kolivas.org>
	<419BA5C4.4020503@atmos.washington.edu>
	<1100722571.20185.9.camel@tux.rsn.bth.se>
	<419BBF57.3040808@atmos.washington.edu>
	<1100727847.20185.31.camel@tux.rsn.bth.se>
	<41A27868.80703@atmos.washington.edu>
	<20041123100450.3cbb82e6@zqx3.pdx.osdl.net>
In-Reply-To: <20041123100450.3cbb82e6@zqx3.pdx.osdl.net> (from
	shemminger@osdl.org on Tue Nov 23 19:04:50 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101249103l.10296l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.23, Stephen Hemminger wrote:
> On Mon, 22 Nov 2004 15:38:16 -0800
> Harry Edmon <harry@atmos.washington.edu> wrote:
> 
> > Tried them all - none of them helped.  Use "ntop" I can see that my 
> > throughput on the Intel gigabit ethernet interface on the system maxes 
> > out at 15.2 Mbps with 2.6.9.  With 2.6.7 it made it to 35 Mbps.
> > 
> > Does anyone have any other suggestions as to what to look for to 
> > diagnose this problem?
> 
> Well, before the TSO changes, if TSO was enabled then TCP would not obey slow
> start or do congestion control properly.  Did you increase the TCP send/receive
> buffers (sysctl's net.ipv4.tcp_rmem and net.ipv4.tcp_wmem)? You may just
> be window limited.  Also, 2.6.9 has TCP bugs with TSO that can cause panic's.
> These have been fixed in 2.6.10-rc2.
> 

With two 2.6.9 boxes (really, 2.6.9-mm1 and 2.6.9-bproc), I get this:

nada:~> iperf -s
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 155.210.155.215 port 5001 connected with 155.210.155.212 port 41695
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec   112 MBytes  94.0 Mbits/sec
annwn:/proc/sys/net> iperf -c nada
------------------------------------------------------------
Client connecting to nada, TCP port 5001
TCP window size: 16.0 KByte (default)
------------------------------------------------------------
[  3] local 155.210.155.212 port 41695 connected with 155.210.155.215 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec   112 MBytes  94.0 Mbits/sec

So 94 Mbits/sec, through 100Mb ether. So parhaps the netsork layer
is not the culprit, just the driver.

BTW:

I'm getting an oops with 2.6.9 that ends on a call to skb_clone,
using e1000. Is this what you refer to ?

If the answer is yes, do you have any pointer to a patch to fix just
this ? I would prefer an individual patch instead of full -bk, because
I use 2.6.9+bproc, and probably bproc wont patch against -bk.

TIA.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


