Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVIFTyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVIFTyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVIFTyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:54:50 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52715 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750832AbVIFTyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:54:49 -0400
Subject: Re: [RFC][PATCH] Use proper casting with signed timespec.tv_nsec
	values
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0509061032010.16745@schroedinger.engr.sgi.com>
References: <1125608627.22448.4.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0509061032010.16745@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:54:37 -0700
Message-Id: <1126036477.14172.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 10:33 -0700, Christoph Lameter wrote:
> On Thu, 1 Sep 2005, john stultz wrote:
> 
> > 	I recently ran into a bug with an older kernel where xtime's tv_nsec
> > field had accumulated more then 2 seconds worth of time. The timespec's
> > tv_nsec is a signed long, however gettimeofday() treats it as an
> > unsigned long. Thus when the failure occured, very strange and difficult
> > to debug time problems occurred.
> 
> How can that happen? I think the source of the problem needs to be fixed. 
> The fix is only going decrease the likelyhood of the problem occurring.

Really it shouldn't, I'm just adding the extra casting to be more
explicit to if at some point in the future a bug does creep up, it will
be easier to understand. The code is assuming we're unsigned, so why not
make that clear to the compiler?

Granted, its not really all that critical and it is a bit paranoid. I
just figured I'd float the patch to see if folks thought it would be a
good idea. 

thanks
-john



