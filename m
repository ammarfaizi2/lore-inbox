Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422786AbWJPSjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWJPSjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 14:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422796AbWJPSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 14:39:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422786AbWJPSju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 14:39:50 -0400
Date: Mon, 16 Oct 2006 11:39:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, johnstul@us.ibm.com
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
Message-Id: <20061016113937.a76f8d06.akpm@osdl.org>
In-Reply-To: <p73odsccqy5.fsf@verdi.suse.de>
References: <1160596462.5973.12.camel@localhost.localdomain>
	<20061011142646.eb41fac3.akpm@osdl.org>
	<1160606911.5973.36.camel@localhost.localdomain>
	<20061011160328.f3e7043a.akpm@osdl.org>
	<p73odsccqy5.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Oct 2006 15:48:02 +0200
Andi Kleen <ak@suse.de> wrote:

> Andrew Morton <akpm@osdl.org> writes:
> > 
> > Is there any actual need to hold xtime_lock while doing the port IO?  I'd
> > have thought it would suffice to do
> > 
> > 	temp = port_io
> > 	write_seqlock(xtime_lock);
> > 	xtime = muck_with(temp);
> > 	write_sequnlock(xtime_lock);
> > 
> > ?
> 
> That would be a good idea in general. The trouble is just that whatever race
> is there will be still there then, just harder to trigger (so instead of 
> every third boot it will muck up every 6 weeks). Not sure that is
> a real improvement.
> 

Confused.  What race are you referring to?

This is addressing a starvation problem which is due to the slowness of the
port-io (iirc).

