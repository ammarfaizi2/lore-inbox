Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVDQK5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVDQK5i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVDQK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 06:57:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261298AbVDQK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 06:57:36 -0400
Subject: Re: More performance for the TCP stack by using additional
	hardware chip on NIC
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113733753.15803.26.camel@avik.scalemp>
References: <d3t63d$3qe$1@pD9F86D3F.dip0.t-ipconnect.de>
	 <1113728880.17394.16.camel@laptopd505.fenrus.org>
	 <1113733753.15803.26.camel@avik.scalemp>
Content-Type: text/plain
Date: Sun, 17 Apr 2005 12:57:31 +0200
Message-Id: <1113735452.17394.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> TOEs can remove the data copy on receive. In some applications (notably
> storage), where the application does not touch most of the data, this is
> a significant advantage that cannot be achieved in a software-only
> solution.

other solutions can too. Search the archives for posts from Dave Miller
and Jeff Garzik on these issues. Note that TOEs per se don't do this,
specific treats of interfaces to TOE *may* allow this. The interesting
part is that the parts of the interface that would allow this can be
implemented without TOE (and all the downsides of full TOE such as
bypassing firewall rules etc etc) just as well.


> > Also these types of solution always add quite a bit of overhead to
> > connection setup/teardown making it actually a *loss* for the "many
> > short connections" types of workloads. Now guess which things certain
> > benchmarks use, and guess what real world servers do :)
> > 
> 
> again, this depends on the application.
> 
> a copyless solution is probably necessary to achieve 10Gb/s speeds.

I've heard the same say abot 100Mbit and 1Gbit. And neither has been
proven true. Don't get me wrong, avoiding copies is always nice, and on
sending linux already enables that (depending on the applications
capabilities). But I personally find it hard to accept that full
copyless operation is a strict requirement to achieve 10Gb/s.

What sure will be required to achieve efficient 10Gb/s performance is a
whole lot of tuning in the network stack and potentially even in the
tcp/ip layer to allow for bigger buffers etc. But I'm pretty sure that
effort is underway already or will be soon...

