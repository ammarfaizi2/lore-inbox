Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUGLNkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUGLNkq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266834AbUGLNkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:40:46 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:24656 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266831AbUGLNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:40:40 -0400
Message-ID: <40F294D2.3010203@yahoo.com.au>
Date: Mon, 12 Jul 2004 23:40:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>
CC: Arjan van de Ven <arjanv@redhat.com>, Daniel Phillips <phillips@istop.com>,
       sdake@mvista.com, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de> <20040712102818.GB31013@devserv.devel.redhat.com> <20040712115003.GV3933@marowsky-bree.de> <20040712120127.GB16604@devserv.devel.redhat.com> <20040712131312.GY3933@marowsky-bree.de>
In-Reply-To: <20040712131312.GY3933@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> On 2004-07-12T14:01:27,
>    Arjan van de Ven <arjanv@redhat.com> said:
> 
> 
>>I'm not convinced that's a good idea, in that it exposes what is
>>basically VM internals to userspace, which then would become a
>>set-in-stone interface....
> 
> 
> But I'm also not a big fan of moving all HA relevant infrastructure into
> the kernel. Membership and DLM are the first ones; then follows
> messaging (and reliable and globally ordered messaging is somewhat
> complex - but if one node is slow, it will hurt global communication
> too, so...), next someone argues that a node always must be able to
> report which resources it holds and fence other nodes even under memory
> pressure, and there goes the cluster resource manager and fencing
> subsystem into the kernel too etc...
> 
> Where's the border? 
> 
> And what can we do to make critical user-space infrastructure run
> reliably and with deterministic-enough & low latency instead of moving
> it all into the kernel?
> 
> Yes, the kernel solves these problems right now, but is that really the
> path we want to head down? Maybe it is, I'm not sure, afterall we also
> have the entire regular network stack in the kernel, but maybe also it
> is not.
> 

I don't see why it would be a problem to implement a "this task
facilitates page reclaim" flag for userspace tasks that would take
care of this as well as the kernel does.

There would probably be a few technical things to work out (like
GFP_NOFS), but I think it would be pretty trivial to implement.
