Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268013AbUJGTvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268013AbUJGTvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUJGTru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:47:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6791 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267869AbUJGTAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:00:07 -0400
Date: Thu, 7 Oct 2004 14:59:45 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, SELinux@tycho.nsa.gov, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4-VP-S7 - ksoftirq and selinux oddity
In-Reply-To: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.58.0410071459030.25178@devserv.devel.redhat.com>
References: <200410070542.i975gkHV031259@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Oct 2004 Valdis.Kletnieks@vt.edu wrote:

> audit(1097111349.782:0): avc:  denied  { recv_msg } for  pid=2 comm=ksoftirqd/0 saddr=127.0.0.1 src=25 daddr=127.0.0.1 dest=59639 netif=lo scontext=system_u:system_r:fsdaemon_t tcontext=system_u:object_r:smtp_port_t tclass=tcp_socket
> 
> At least for the recv_msg error, I *think* the message is generated
> because when we get into net/socket.c, we call security_socket_recvmsg()
> in __recv_msg() - and (possibly only when we have the VP patch applied?)
> at that point we're in a softirqd context rather than the context of the
> process that will finally receive the packet, so the SELinux code ends
> up checking the wrong credentials.  I've not waded through the code
> enough to figure out exactly where the two tcp_recv messages are
> generated, but I suspect the root cause is the same for all three
> messages.

that would be a problem in the upstream kernel too - softirq load can
execute in any process context (and in ksoftirqd too).

	Ingo
