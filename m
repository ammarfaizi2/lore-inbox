Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270588AbUJTX2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270588AbUJTX2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270589AbUJTX2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:28:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52947 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269186AbUJTX0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:26:03 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>,
       Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1098298310.12411.11.camel@localhost.localdomain>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <41768858.8070709@techsource.com>
	 <20041020153521.GB21556@devserv.devel.redhat.com>
	 <1098290345.1429.65.camel@krustophenia.net>
	 <1098298310.12411.11.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098314395.2758.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 19:19:56 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 14:51, Alan Cox wrote:
> On Mer, 2004-10-20 at 17:39, Lee Revell wrote:
> > The IDE I/O completion in hardirq context means that one can run for
> > almost 3ms.  Apparently at OLS it was decided that the target for
> > desktop responsiveness was 1ms.  So this is a real problem.
> > 
> > What exactly do you mean by "draconian"?
> 
> It means "fix the ide layer", patches welcome. 
> 

In addition to the IDE layer how about this (from the link in my
previous mail):

On Sat, 2004-07-24 at 02:43, Ingo Molnar wrote: 
> 
> Another thing would be to create a compound structure for bio and
> [typical sizes of] bio->bi_io_vec and free them as one entity, this
> would get rid of one of the cachemisses. (there cannot be a 3-way
> compound structure that includes the bh too because the bh is freed
> later on by ext3.)
> 

Sounds like a big win for any user of the bio layer, if it's as
straightforward as Ingo says...

Lee

