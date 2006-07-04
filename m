Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWGDTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWGDTYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWGDTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:24:43 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:46247 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S932221AbWGDTYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:24:42 -0400
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <44AA9951.1060804@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	 <449CD4B3.8020300@watson.ibm.com> <44A01A50.1050403@sgi.com>
	 <20060626105548.edef4c64.akpm@osdl.org> <44A020CD.30903@watson.ibm.com>
	 <20060626111249.7aece36e.akpm@osdl.org> <44A026ED.8080903@sgi.com>
	 <20060626113959.839d72bc.akpm@osdl.org> <44A2F50D.8030306@engr.sgi.com>
	 <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com>
	 <20060629014050.d3bf0be4.pj@sgi.com>
	 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	 <20060629094408.360ac157.pj@sgi.com>
	 <20060629110107.2e56310b.akpm@osdl.org> <44A57310.3010208@watson.ibm.com>
	 <44A5770F.3080206@watson.ibm.com> <20060630155030.5ea1faba.akpm@osdl.org>
	 <44A5DBE7.2020704@watson.ibm.com> <44A5EDE6.3010605@watson.ibm.com>
	 <20060630205148.4f66b125.akpm@osdl.org> <44A9881F.7030103@watson.ibm.com>
	 <44A9BC4D.7030803@watson.ibm.com> <20060703180151.56f61b31.akpm@osdl.org>
	 <1152018353.5214.14.camel@jzny2> <44AA86BF.3090600@watson.ibm.com>
	 <44AA9951.1060804@watson.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Tue, 04 Jul 2006 15:24:30 -0400
Message-Id: <1152041070.5276.29.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh,

On Tue, 2006-04-07 at 12:37 -0400, Shailabh Nagar wrote:
[..]
> Here's a strawman for the problem we're trying to solve: get
> notification of the close of a NETLINK_GENERIC socket that had
> been used to register interest for some cpus within taskstats.
> 
>  From looking at the netlink code, the way to go seems to be
> 
> - it maintains a pidhash of nl_pids that are currently
> registered to listen to atleast one cpu. It also stores the
> cpumask used.
> - taskstats registers a notifier block within netlink_chain
> and receives a callback on the NETLINK_URELEASE event, similar
> to drivers/scsci/scsi_transport_iscsi.c: iscsi_rcv_nl_event()
> 
> - the callback checks to see that the protocol is NETLINK_GENERIC
> and that the nl_pid for the socket is in taskstat's pidhash. If so, it
> does a cleanup using the stored cpumask and releases the nl_pid
> from the pidhash.
> 

Sound quiet reasonable.  I am beginning to wonder whether we should do 
do the NETLINK_URELEASE in general for NETLINK_GENERIC

> We can even do away with the deregister command altogether and
> simply rely on this autocleanup.

I think if you may still need the register if you are going to allow
multiple sockets per listener process, no?
The other question is how do you correlate pid -> fd?

cheers,
jamal



