Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbTBDQfl>; Tue, 4 Feb 2003 11:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTBDQfl>; Tue, 4 Feb 2003 11:35:41 -0500
Received: from host194.steeleye.com ([66.206.164.34]:35082 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S266100AbTBDQfk>; Tue, 4 Feb 2003 11:35:40 -0500
Subject: Re: PnP Model
From: James Bottomley <James.Bottomley@steeleye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mochel@osdl.org
In-Reply-To: <1044290479.21009.7.camel@irongate.swansea.linux.org.uk>
References: <1044286316.1777.30.camel@mulgrave> 
	<1044290479.21009.7.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Feb 2003 10:45:08 -0600
Message-Id: <1044377110.1776.16.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 10:41, Alan Cox wrote:
> On Mon, 2003-02-03 at 15:31, James Bottomley wrote:
> > The last issue is probably that we'd like the ISA probes to be run after
> > all the rest of the busses so that all resources in use in the system
> 
> They need to run very early on in some ways. We don't want to assign a
> PnP device over something we didnt know exists. We can scan the other
> busses first safely but we can't activate devices or do anything else
> until the ISA unsafe probes run. Those also have some very careful
> ordering especially in networking. NE2000 must run early, other probes
> can make some cards move around so must also be ordered


It strikes me that we can make use of the bus matching logic for this. 
For ISA, since we have no concept of a card id, we could instead match
on when the binding should occur (i.e. ISA_BIND_EARLY and
ISA_BIND_LATE).  Thus each driver picks its binding type and we run bind
early before all other busses and bind late after them (probably by
simulating a hotplug event that says hey I suddenly found a bunch of ISA
cards of type ISA_BIND_LATE).  It's a bit of an abuse of what bus
matching is supposed to do, but it should work for the purpose

James



