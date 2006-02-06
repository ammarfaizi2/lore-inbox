Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWBFOkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWBFOkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWBFOkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:40:07 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:31148 "EHLO fisica.ufpr.br")
	by vger.kernel.org with ESMTP id S1751097AbWBFOkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:40:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <17383.24476.747110.629245@fisica.ufpr.br>
Date: Mon, 6 Feb 2006 12:39:24 -0200
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfsroot doesn't work with intel card since 2.6.12.2/2.6.11
In-Reply-To: <43E70BE3.1080805@t-online.de>
References: <43E70BE3.1080805@t-online.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: carlos@fisica.ufpr.br (Carlos Carvalho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen (Knut_Petersen@t-online.de) wrote on 6 February 2006 09:42:
 >1. How do you boot the kernel? Bootrom?
 >    If yes: Which protocol? PXE + pxelinux? Etherboot? ...

Yes, pxe on the Intel card plus pxelinux. The machines are diskless
with Tyan S2466 motherboards. I don't use the on-board 3Com ether chip
(which works and boots fine, btw).

 >2. Does ip auto configuration (e.g. ip=dhcp at kernel command line) work?
 >    If you do see the "IP-Config: Complete:" message while booting

Yes, this works fine. The kernel gets it from pxelinux directly via
option IPAPPEND.

Here's what I copied manually from the screen after the IP-Config:
line:

looking up port of RPC 100003/2 on 192.168.1.1 (the server)
e1000: e1000_watchdog_task: nic link is up 1000 Mbs full duplex
portmap: server 192.168.1.1 not responding, timed out
root-nfs: unable to get nfsd port number from server, using default
looking up port of RPC 100005/1 on 192.168.1.1
portmap: server 192.168.1.1 not responding, timed out
root-nfs: unable to get mountd port number from server, using default
root-nfs: server returned -5 while mounting /home/nfsroot/servers-root

I said before that there is a progressive degradation at each kernel
version. Some versions before 2.6.12.2/driver 2.6.11 there were no
portmap problems at all. 2.6.12.2/driver 2.6.11 says that it couldn't
get the port number from the server but manages to boot using the
default.

 >4. Could it be that you try to mount root using nfs version 2?
 >    The current linux nfs 2 server is unable to serve the current nfs 2 
 >client.

Wonderful :-(

 >    Unfortunately  version 2 is the default. Add the v3 parameter:
 >
 >        root=/dev/nfs nfsroot=%s,rsize=8192,wsize=8192,v3

Why do the previous versions work? Why does 2.6.15.2 work with a
Marvell/Yukon ether chip?

Trond asked about using tcp. I prefer to use udp because it has less
overhead. This is a computing cluster, all machines are in the same
room connected to a HP 4108gl gigabit switch. It's not a cable or
switch port problem, all machines exhibit the same behavior.
