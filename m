Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422797AbWJPSme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWJPSme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWJPSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:42:34 -0400
Received: from ns2.suse.de ([195.135.220.15]:42139 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422797AbWJPSmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:42:33 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
Date: Mon, 16 Oct 2006 20:42:27 +0200
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, johnstul@us.ibm.com
References: <1160596462.5973.12.camel@localhost.localdomain> <p73odsccqy5.fsf@verdi.suse.de> <20061016113937.a76f8d06.akpm@osdl.org>
In-Reply-To: <20061016113937.a76f8d06.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610162042.27292.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 20:39, Andrew Morton wrote:
> On 16 Oct 2006 15:48:02 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > Andrew Morton <akpm@osdl.org> writes:
> > > 
> > > Is there any actual need to hold xtime_lock while doing the port IO?  I'd
> > > have thought it would suffice to do
> > > 
> > > 	temp = port_io
> > > 	write_seqlock(xtime_lock);
> > > 	xtime = muck_with(temp);
> > > 	write_sequnlock(xtime_lock);
> > > 
> > > ?
> > 
> > That would be a good idea in general. The trouble is just that whatever race
> > is there will be still there then, just harder to trigger (so instead of 
> > every third boot it will muck up every 6 weeks). Not sure that is
> > a real improvement.
> > 
> 
> Confused.  What race are you referring to?

Sorry s/race/starvation/

> 
> This is addressing a starvation problem which is due to the slowness of the
> port-io (iirc).

Is it just sure to go away when the critical section is shorter?

-Andi


 
