Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbUENW4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUENW4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUENW4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:56:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:48811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263104AbUENW4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:56:45 -0400
Date: Fri, 14 May 2004 15:56:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       arjanv@redhat.com, benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514155643.G22989@build.pdx.osdl.net>
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston> <20040513182153.1feb488b.akpm@osdl.org> <20040514094923.GB29106@devserv.devel.redhat.com> <20040514114746.GB23863@wohnheim.fh-wedel.de> <20040514151520.65b31f62.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040514151520.65b31f62.akpm@osdl.org>; from akpm@osdl.org on Fri, May 14, 2004 at 03:15:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > On Fri, 14 May 2004 11:49:23 +0200, Arjan van de Ven wrote:
> > > On Fri, May 14, 2004 at 11:47:39AM +0200, Andrew Morton wrote:
> > > > There's a `make buildcheck' target in -mm (from Arjan) into which we could
> > > > integrate such a tool.  Although probably it should be a different make
> > > > target.
> > > 
> > > I added it to buildcheck for now, based on Keith Owens' check-stack.sh
> > > script. I added a tiny bit of perl (shudder) to it to 
> > > 1) Make it print in decimal not hex
> > > 2) Filter the stack users to users of 400 bytes and higher
> > > 
> > > I arbitrarily used 400; that surely is debatable.
> > 
> > Keith' script has the major disadvantage of not working on anything
> > but i386.  Here is my old script that works on a few more.
> 
> That's nice and simple.  All due respect to Keith, this is something
> which humans have a chance of understanding too ;)
> 
> I removed the `vmlinux FORCE' targets from the makefile - that was forcing
> a full rebuild after I'd just done one.  Just let it check ./vmlinux and if
> it's not there, it errors out...
> 
> It doesn't do modules, and hence requires a prior allyesconfig.  I think it
> would be better to do:
> 
> find . -name '*.o' | xargs objdump -d | perl scripts/checkstack.pl i386
> 
> but that produces slightly screwy output and, for some reason, duplicated
> output:

maybe from the .o and .mod.o?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
