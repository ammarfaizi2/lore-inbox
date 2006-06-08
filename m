Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWFIAtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWFIAtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWFIAtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 20:49:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:54177 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965063AbWFIAtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 20:49:23 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <Pine.LNX.4.64.0606081545150.17704@scrub.home>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
	 <1149656647.27572.128.camel@localhost.localdomain>
	 <20060606222942.43ed6437.akpm@osdl.org>
	 <1149662671.27572.158.camel@localhost.localdomain>
	 <20060607132155.GB14425@elte.hu>
	 <1149726685.23790.8.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606081301320.17704@scrub.home>
	 <1149773911.31114.36.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606081545150.17704@scrub.home>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 09:40:30 +1000
Message-Id: <1149810031.22496.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 16:02 +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 8 Jun 2006, Benjamin Herrenschmidt wrote:
> 
> > > On ppc it should not be that difficult to even modify the exception entry 
> > > code. Instead of calling do_IRQ use do_early_IRQ and only install the real 
> > > handler later.
> > 
> > Yes, it's possible, but will add overhead to the common  IRQ path just
> > to handle an early boot special case.
> 
> What I mean is to directly patch the exception entry code, so after the 
> initialization is complete you'll have no additional overhead.
> In the EXC_XFER_TEMPLATE() macro the handler is stored at i##n. You can 
> either export that address or you can use a special transfer handler, 
> which automatically patches the values once some flag is set.

That is a possibility. Also totally PPC specific for a problem that will
hit every arch once I start moving things around in the init code. I
still think that the best way is to fix the mutex code. You remember
what you can read on most public toilets about leaving them in the state
you found them ? Sounds like a pretty good rule to me here as well.

Ben.

