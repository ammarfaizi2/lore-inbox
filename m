Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGOFno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTGOFno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:43:44 -0400
Received: from almesberger.net ([63.105.73.239]:33039 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262710AbTGOFnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:43:32 -0400
Date: Tue, 15 Jul 2003 02:58:13 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David griego <dagriego@hotmail.com>, jgarzik@pobox.com,
       alan@storlinksemi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Message-ID: <20030715025813.B5608@almesberger.net>
References: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com> <1058213152.561.129.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058213152.561.129.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 14, 2003 at 09:05:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> load balancer. If you want to argue about using gate arrays and hardware
> to accelerate IP routing, balancing and firewall filter cams then you
> might get somewhere - but they dont need to talk TCP.

One thing that sounds right about TOE is that per-packet overhead
is becoming an issue, too. At 10 Gbps, the critters come flying in
at almost 1 MHz if you're using standard MTU sizes.

On the other hand, replicating the entire infrastructure on some
non-Linux hardware has several problems, even if we don't consider
performance:

 - where is the configuration interface ? In the kernel or in
   user space ? What about existing interfaces ?
 - you'll never get exactly the same semantics. Just identifying
   the differences is a very painful process. And again, what
   about existing interfaces ?
 - testing has just become a lot harder

What I think would be more promising is to investigate in the
direction of NUMA-style architectures, where some CPUs are closer
to NICs and whatever data source/sink those TCP streams go to.

Licensing issues, the classical reason for using independent
stacks, can be elegantly avoided on Linux.

Another area are network processors. They could help with fancy
things like Dave's flow cache, but also with fine-grained timing
needed for traffic control. One problem there is that they're
locked away behind walls of NDAs and proprietary development
environments, so one couldn't even begin to properly support them
in Linux. (What can be done is to treat NP+software as a black
box, but I wouldn't consider this a satisfying choice.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
