Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUIGQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUIGQJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUIGQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:08:46 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:14566 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268230AbUIGPeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:34:21 -0400
Date: Tue, 7 Sep 2004 17:34:18 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Einar Lueck <elueck@de.ibm.com>
Cc: Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Message-ID: <20040907153418.GC19354@MAIL.13thfloor.at>
Mail-Followup-To: Einar Lueck <elueck@de.ibm.com>,
	Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org
References: <200409011441.10154.elueck@de.ibm.com> <200409021858.38338.elueck@de.ibm.com> <Pine.LNX.4.61.0409022147220.23011@fogarty.jakma.org> <200409031007.29467.elueck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409031007.29467.elueck@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 10:07:29AM +0200, Einar Lueck wrote:
> On Donnerstag, 2. September 2004 22:59 Paul Jakma wrote:
> > 
> > I dont see why it wouldnt work, it almost undoubtedly will work for 
> > NFS over TCP. And any problems to cause it to not work would be best 
> > taking up on the linux-nfs list in order to have a "bind to address" 
> > option added to knfsd.
> 
> I just set up the loopback interface via ZEBRA/OSPF as You described it 
> and checked via tcpdump the source IP address of the related NFS packets.
> The kernel chooses the IP address of the NIC he routes the packets over as
> the source IP address and not the Source VIPA configured for loopback.  
> 
> You are right, it would be one option to have a "bind to address" in KNFSD.
> But our idea was to implement a feature well known from other operating 
> systems like AIX to Linux because this feature is quite popular and liked 
> especially by large customers.  As You have read for sure such a feature
> adding redundant functionality to the kernel is not desired. So maybe we
> should continue our discussion privately. Thanks for Your suggestions!
> 
> > 
> > Why could it not be solved? And why is the answer not "ask the knfsd 
> > people to provide bind-to-ip option"?
> > 
> 
> We would win a facility allowing for a Source VIPA for all
> kinds of servers not offering an explicit bind option. So: Due to the 
> feature port idea mentioned above.

btw, something very similar is implemented and used
by linux-vserver (it's called chbind) to restrict
0.0.0.0 (IADDR_ANY) binds to specified address(es)

if you need more details, just let me know ...

best,
Herbert

> > But on a server, the packets that go out tend to be replies to 
> > requests. Or at least, the only packets of interest are replies. It's 
> > a rare server that just off its own bat goes and talks to clients 
> > which have not communicated first with the server before.
> 
> The enterprise customers we care about have for example servers
> that utilize other servers (application servers utilizing a database or
> a NFS server, etc.). So to generate replies these servers need
> replies of other servers .
> 
> > 
> > Anyway, even if the server for some reason initiated traffic, the 
> > correct answer surely is "modify the server to bind to a specific 
> > address", no?
> 
> As mentioned above ;)
> 
> > 
> > > Bonding offers a failover facility. For more details, please refer to:
> > > Documentation/networking/bonding.txt in the kernel tree.
> > 
> > Right, but what does bonding (layer 2) have to do with virtual IPs 
> > and IP source address?
> > 
> 
> If we focus for a moment just on the NIC-fail-over issue (not caring 
> about layers, virtual IPs, etc.) then bonding offers the desired failover with
> some restriction. This is the reason why I mentioned it in this context.
> 
> Again, thanks for Your suggestions and maybe we should continue our 
> discussion privately.
> 
> Regards
> 
> Einar.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
