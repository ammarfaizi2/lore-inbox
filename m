Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWIKSMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWIKSMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWIKSMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:12:01 -0400
Received: from outbound-mail-01.bluehost.com ([70.103.189.11]:24194 "HELO
	outbound-mail-01.bluehost.com") by vger.kernel.org with SMTP
	id S932226AbWIKSMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:12:00 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 11:12:29 -0700
User-Agent: KMail/1.9.4
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <200609101725.49234.jbarnes@virtuousgeek.org> <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
In-Reply-To: <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111112.29403.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 70.103.140.128 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 10, 2006 5:54 pm, Segher Boessenkool wrote:
> >>  - writel/readl become totally ordered (including vs. memory).
> >> Basically x86-like. Expensive (very expensive even on some
> >> architectures) but also very safe.
> >
> > This approach will minimize driver changes, and would imply the
> > removal
> > of some existing mmiowb() and wmb() macros.
>
> Like I tried to explain already, in my competing approach, no drivers
> would need changes either.  And you could remove those macro's (or
> their more-verbosely-saying-what-their-doing, preferably bus-specific
> as well) as well -- but you'll face the wrath of those who care about
> performance of those drivers on non-x86 platforms.

Right, at the cost of more complexity in the accessor routines.

> Hence my proposal of calling it pci_cpu_to_cpu_barrier() -- what it
> orders is accesses from separate CPUs.  Oh, and it's bus-specific,
> of course.

Makes sense to me, I have no problem with that name since it's really intended 
to order posted PCI writes from different CPUs.

Jesse
