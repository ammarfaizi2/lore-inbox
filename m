Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVEMTLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVEMTLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbVEMTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:06:50 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:31846 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S262487AbVEMTDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:03:02 -0400
Date: Fri, 13 May 2005 12:02:44 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Daniel Jacobowitz <dan@debian.org>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513190244.GA4167@hexapodia.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050513124735.GA7436@ip68-225-251-162.oc.oc.cox.net> <4284B55C.7010202@pobox.com> <20050513142336.GA6174@nevyn.them.org> <4284BA90.5080508@pobox.com> <20050513171300.GA30909@hexapodia.org> <Pine.LNX.4.58.0505131129060.6631@shell1.sea5.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505131129060.6631@shell1.sea5.speakeasy.net>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 11:30:27AM -0700, Vadim Lobanov wrote:
> On Fri, 13 May 2005, Andy Isaacson wrote:
> > It's a side channel timing attack on data-dependent computation through
> > the L1 and L2 caches.  Nice work.  In-the-wild exploitation is
> > difficult, though; your timing gets screwed up if you get scheduled away
> > from your victim, and you don't even know, because you can't tell where
> > you were scheduled, so on any reasonably busy multiuser system it's not
> > clear that the attack is practical.
> 
> Wouldn't scheduling appear as a rather big time delta (in measuring the
> cache access times), so you would know to disregard that data point?
> 
> (Just wondering... :-) )

Good question.  Yes, you can probably filter the data.  The question is,
how hard is it to set up the conditions to acquire the data?  You have
to be scheduled on the same core as the target process (sibling
threads).  And you don't know when the target is going to be scheduled,
and on a real-world system, there are other threads competing for
scheduling; if it's SMP (2 core, 4 thread) with perfect 100% utilization
then you've only got a 33% chance of being scheduled on the right
thread, and it gets worse if the machine is idle since the kernel should
schedule you and the OpenSSL process on different cores...

Getting the conditions right is challenging.  Not impossible, but
neither is it a foregone conclusion.

-andy
