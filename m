Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272614AbTG1BY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272611AbTG1BYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 21:24:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55475 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272609AbTG1BXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:23:46 -0400
Date: Sun, 27 Jul 2003 18:35:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Carlos Velasco" <carlosev@newipnet.com>
Cc: bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030727183547.784b6ab5.davem@redhat.com>
In-Reply-To: <200307280323020667.10D68954@192.168.128.16>
References: <Pine.LNX.4.53.0307272239570.2743@vialle.bloemsaat.com>
	<200307280140470646.1078EC67@192.168.128.16>
	<20030727164649.517b2b88.davem@redhat.com>
	<200307280158250677.10891156@192.168.128.16>
	<20030727165831.05904792.davem@redhat.com>
	<200307280211590888.10957DD9@192.168.128.16>
	<20030727171403.6e5bcc58.davem@redhat.com>
	<200307280235210263.10AADFF8@192.168.128.16>
	<20030727173600.475d95fb.davem@redhat.com>
	<200307280253090799.10BB2DF0@192.168.128.16>
	<20030727175557.1d624b36.davem@redhat.com>
	<200307280323020667.10D68954@192.168.128.16>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 03:23:02 +0200
"Carlos Velasco" <carlosev@newipnet.com> wrote:

> On 27/07/2003 at 17:55 David S. Miller wrote:
> >With or without your suggestion, people have to do something
> >different.
> 
> Just enabling the hidden switch solved my setting and I think it solves
> most of "problem" settings.

So do my suggestions.

I don't deny that it fixes your problem, that is not what
we're talking about.  We're talking about how one should
fix the problem, and I'm trying to show you why "hidden"
patch is not the answer to that.

> >This doesn't even address all the problems there are with
> >the hidden patch.  It does things that belong on the netfilter
> >level and not on the ARP/routing level.
> 
> Well... it's just your opinion... other OS and systems don't use
> netfilter of firewalling at all (ex. Win) and behave like with "hidden"
> applied.

Ummm, with "hidden" you still have to make a configuration change.

Second of all, "hidden" makes the kernel behave in a non-RFC compliant
way.  This is the categorization that I use to determine if something
belongs on the netfilter level or not.

If something changes the way in which the Linux networking
behaves wrt. RFCs, this "operation" belongs at the netfilter level.

This is true for the "hidden" patch.  It causes the system to
ignore ARP requests it should respond to.

On the other hand, the "arpfilter" sysctl setting makes the kernel
still behave in an RFC compliant manner, it only responds to ARPs
on interfaces it would use to speak to the requestor.

> Really, the only one I have tested that not do it is Linux 2.2+

Yes, we removed "hidden" from 2.2.x in lieu of "arpfilter" sysctl
and the netfilter ARP filtering module.

> For me (not a kernel developer), my world are the OSI layers,

OSI layers have nothing to do with the problem we are discussing.

BTW, OSI layers are how networking stacks are described in textbooks
and standards and far away from how one should implement said stack.
Van Jacobson even said this once :-)

> I will look... but doing arp filter is not a real simple solution in
> any way.

It would be really nice if people might consider that it could even be
possible to make things like the IPVS layer install the appropriate
NETFILTER_ARP chain rules when the IPVS configuration installed dictates
that one is needed.

People using IPVS wouldn't even need to do _ANYTHING_ if IPVS were
to do that.

And all of that would be _FINE_ because like ARP netfilter, IPVS lies
inside of netfilter where such things which change networking behavior
semantics radically belong.
