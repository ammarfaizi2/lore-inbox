Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWDJQ6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWDJQ6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDJQ6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 12:58:08 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29065 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750873AbWDJQ6G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 12:58:06 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1144660270.5816.3.camel@openx2.frec.bull.fr>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
Content-Type: text/plain; charset=utf-8
Organization: IBM LTC
Date: Mon, 10 Apr 2006 09:57:59 -0700
Message-Id: <1144688279.3964.7.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 11:11 +0200, Laurent Vivier wrote:
> Le jeu 30/03/2006 à 03:54, Andrew Morton a écrit :
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > >
> > > The things need to be done to complete this work is the issue with
> > >  current percpu counter, which could not handle u32 type count well. 
> > 
> > I'm surprised there's much of a problem here.  It is a 32-bit value, so it
> > should mainly be a matter of treating the return value from
> > percpu_counter_read() as unsigned long.
> > 
> > However a stickier problem is when dealing with a filesystem which has,
> > say, 0xffff_ff00 blocks.  Because percpu counters are approximate, and a
> > counter which really has a value of 0xffff_feee might return 0x00000123. 
> > What do we do then?
> > 
> > Of course the simple option is to nuke the percpu counters in ext3 and use
> > atomic_long_t (which is signed, so appropriate treat-it-as-unsigned code
> > would be needed).  I doubt if the percpu counters in ext3 are gaining us
> > much.
> 
> I tried to make something in this way.
> Does the attached patch look like the thing you though about ?
> 

I tried the other way -- I am trying to keep the percpu counter in use
in ext2/3 as much as possible.  I proposed a fix for percpu counter to
deal with the possible "overflow" (i.e, a counter really has a value of
0xfff_feee and after updating one local counter it truens 0x00000123).
Will send the proposed patch out for review and comments soon.

Mingming

