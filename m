Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUENXZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUENXZM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUENXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:24:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:47547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264543AbUENXQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:16:09 -0400
Date: Fri, 14 May 2004 16:18:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: joern@wohnheim.fh-wedel.de, arjanv@redhat.com, benh@kernel.crashing.org,
       kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040514161814.3e1f690e.akpm@osdl.org>
In-Reply-To: <20040514155643.G22989@build.pdx.osdl.net>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040513182153.1feb488b.akpm@osdl.org>
	<20040514094923.GB29106@devserv.devel.redhat.com>
	<20040514114746.GB23863@wohnheim.fh-wedel.de>
	<20040514151520.65b31f62.akpm@osdl.org>
	<20040514155643.G22989@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> > It doesn't do modules, and hence requires a prior allyesconfig.  I think it
> > would be better to do:
> > 
> > find . -name '*.o' | xargs objdump -d | perl scripts/checkstack.pl i386
> > 
> > but that produces slightly screwy output and, for some reason, duplicated
> > output:
> 
> maybe from the .o and .mod.o?

Well find .  -name '*.o' -a -not -name '*.mod.o' would fix that up but the
dupes are coming from the intermediate .o files which the build system
prepares.  sound/core/snd.o contains sound/core/snd-pcm.o contains
sound/core/pcm_native.o.

hmm.
