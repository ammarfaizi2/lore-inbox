Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWCDMdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWCDMdK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWCDMdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:33:10 -0500
Received: from ozlabs.org ([203.10.76.45]:31934 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932088AbWCDMdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:33:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17417.35072.247188.486774@cargo.ozlabs.ibm.com>
Date: Sat, 4 Mar 2006 23:33:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, anemo@mba.ocn.ne.jp, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
In-Reply-To: <20060304034449.3fd5e2fa.akpm@osdl.org>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
	<20060304001834.0476e8e9.akpm@osdl.org>
	<20060304112010.GA94875@muc.de>
	<17417.32015.6281.253814@cargo.ozlabs.ibm.com>
	<20060304034449.3fd5e2fa.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Paul Mackerras <paulus@samba.org> wrote:
> >
> > Andi Kleen writes:
> > 
> > > Also I assume Atsushi-san did the patch because he saw a real problem?
> > 
> > Yes, one which I also saw on PPC.  The compiler (gcc-4) emits loads
> > for jiffies, jiffies64 and wall_jiffies before storing the incremented
> > jiffies64 value back.
> > 
> 
> What was the effect of that?

The effect is that the first call to do_timer doesn't increment xtime.
This explains why the code I have to detect disagreements between
xtime and the time of day as computed from the timebase register was
finding a disagreement on the first tick, which I was scratching my
head over.

There may be other effects on architectures which use wall_jiffies to
detect lost timer ticks.  We don't have that problem on PPC and we
don't use wall_jiffies in computing time of day.

Paul.

