Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317212AbSFRBhz>; Mon, 17 Jun 2002 21:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSFRBhy>; Mon, 17 Jun 2002 21:37:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62897 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317212AbSFRBhx>;
	Mon, 17 Jun 2002 21:37:53 -0400
Subject: Re: [Patch] tsc-disable_A5
From: john stultz <johnstul@us.ibm.com>
To: Kurt Garloff <garloff@suse.de>
Cc: Benjamin LaHaise <bcrl@redhat.com>, marcelo@conectiva.com.br,
       lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <20020618004823.GB3448@gum01m.etpnet.phys.tue.nl>
References: <1024079726.29929.131.camel@cog>
	<20020614145307.G22888@redhat.com> 
	<20020618004823.GB3448@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 18:31:49 -0700
Message-Id: <1024363910.942.32.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-17 at 17:48, Kurt Garloff wrote:
> Hi Ben,
> 
> On Fri, Jun 14, 2002 at 02:53:07PM -0400, Benjamin LaHaise wrote:
> > On Fri, Jun 14, 2002 at 11:35:26AM -0700, john stultz wrote:
> > > This results in sequential calls to gettimeofday to return
> > > non-sequential time values. By disabling the TSCs on these boxes, it
> > > forces gettimeofday to use the PIC clock instead, fixing the problem. 
> > 
> > This seems to be yet another reason for supporting per-CPU TSC 
> > calibration, as that would fix machines with different speed cpus, too.
> 
> I agree.
> Maybe the patch I once made to support CPUs with different speeds can serve
> as a starting point?
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0481.html
> 
> However, one would need to make sure that all CPUs occasionally do receive
> timer interrupts, otherwise your TSC may overflow. Depending on your
> hardware (APICs), this might be an issue. I've been told that Fosters do
> misbehave ...

Hmmm, I've skimmed your patch before, but really only just for the
lowest common features bit. I didn't quite grasp it last time, but I
really like what you're doing there. TSC overflow can be almost
eliminated if we use the full 64bits, but if we can round robin the
interrupts, that would help compensate for any skew in the clocks.

Thanks for the pointer!
-john




