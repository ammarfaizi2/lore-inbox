Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbTI3O6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTI3O6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:58:52 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:41990 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261538AbTI3O6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:58:48 -0400
Date: Tue, 30 Sep 2003 12:04:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030930150430.GA2996@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, "David S. Miller" <davem@redhat.com>,
	netdev@oss.sgi.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de> <20030929003229.GM1039@conectiva.com.br> <20030929221129.7689e088.davem@redhat.com> <20030930133729.GJ295@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930133729.GJ295@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 30, 2003 at 03:37:29PM +0200, Adrian Bunk escreveu:
> On Mon, Sep 29, 2003 at 10:11:29PM -0700, David S. Miller wrote:
> > On Sun, 28 Sep 2003 21:32:30 -0300
> > Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> > 
> > > Em Mon, Sep 29, 2003 at 02:14:39AM +0200, Adrian Bunk escreveu:
> > > > On Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > What about the following solution (the names and help texts for the
> > > > config options might not be optimal, I hope you understand the
> > > > intention):
> > > > 
> > > > config IPV6_SUPPORT
> > > > 	bool "IPv6 support"
> > > > 
> > > > config IPV6_ENABLE
> > > > 	tristate "enable IPv6"
> > > > 	depends on IPV6_SUPPORT
> > > > 
> > > > IPV6_SUPPORT changes structs etc. and IPV6_ENABLE is responsible for 
> > > > ipv6.o .
> > > 
> > > Humm, and the idea is? This seems confusing, could you elaborate on why such
> > > scheme is a good thing?
> > 
> > I think the idea is totally broken.  At first, Adrian comments that
> > changing the layout of structs based upon a config option is broken,
> > then he proposes a config option that does nothing except change the
> > layout of structures.
> > 
> > The current situation is perfectly fine.
> 
> I did perhaps express my opinion not clearly.
> 
> My personal opinions:
> 
> It's OK that setting an option to y changes structs or whatever else in 
> the kernel.
> 
> It's not OK if adding a module changes the layout of structs compiled 
> into the kernel.
> 
> Modules have many advantages, one advantage is e.g. that they allow 
> generic distribution kernels without resulting in huge kernel images.
> 
> Another advantage is that you can later add modules to a running kernel, 
> you can compile a module for your kernel and insert it without rebooting 
> the machine. This is currently not possible with moduler IPv6.
> 
> That was my personal opinion.
> 
> My opinions seem to be very close to the opinions of David Woodhouse, so 
> there's no need to repeat your discussion.

And just for the record, as a matter of taste I'd like to see all #ifdefs in
structs to disappear, look at what I did to struct sock in 2.5 and look at
struct sock (include/net/sock.h) in 2.4: no #ifdefs where there was a ton,
what I disagree is to make IPV6 not to be built as a module, that would harm
generic kernels, what I said was that this has to be fixed properly, this
requires time and we are too late in 2.6 for such bigger changes, as this is
not just #ifdefs in structs, it is #ifdefs in the IPV4 code, etc.

Lets revisit this in 2.7.

- Arnaldo

For the record: I did an audit in 99% of the headers in the linux source tree,
#ifdefs in structs are mostly just for: CONFIG_PROCFS, DEBUG, NETFILTER and
IPV6, and just a few.
