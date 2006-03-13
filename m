Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWCMC2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWCMC2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 21:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWCMC2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 21:28:46 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:61454 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750883AbWCMC2q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 21:28:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vl1RbzO+Fkvot0wbygmSK/VU2rYyMeTMdYRXLuDspz7/7nb1mFLGaKU8Y4Dl1hJd3/61u5J5WZ33uknqEjGfsQqguPjH07boZ1yg72ni23aRKlpsca9osA6ZMjnEXV2sL7ee6mmq+1+o36a38wtXDqD46eWJVxd0iKyMFhWFNS8=
Message-ID: <aec7e5c30603121828j11c43972yfe642e0f3e1dbef9@mail.gmail.com>
Date: Mon, 13 Mar 2006 11:28:45 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Peter Zijlstra" <peter@programming.kicks-ass.net>
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <1142110694.2928.6.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <1141977139.2876.15.camel@laptopd505.fenrus.org>
	 <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
	 <1142110694.2928.6.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, Peter Zijlstra <peter@programming.kicks-ass.net> wrote:
> On Fri, 2006-03-10 at 14:19 +0100, Magnus Damm wrote:
> > On 3/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > > Apply on top of 2.6.16-rc5.
> > > >
> > > > Comments?
> > >
> > >
> > > my big worry with a split LRU is: how do you keep fairness and balance
> > > between those LRUs? This is one of the things that made the 2.4 VM suck
> > > really badly, so I really wouldn't want this bad...
> >
> > Yeah, I agree this is important. I think linux-2.4 tried to keep the
> > LRU list lengths in a certain way (maybe 2/3 of all pages active, 1/3
> > inactive). In 2.6 there is no such thing, instead the number of pages
> > scanned is related to the current scanning priority.
>
> This sounds wrong, the active and inactive lists are balanced to a 1:1
> ratio. This is happens because the scan speed is directly proportional
> to the size of the list. Hence the largest list will shrink fastest -
> this gives a natural balance to equal sizes.

Yes, you are explaining the current 2.6 behaviour much better. Also,
some balancing logic with nr_scan_active/nr_scan_inactive is present
in the code today. I'm not entirely sure about the purpose of that
code.

Thanks,

/ magnus
