Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWCNJEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWCNJEW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCNJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 04:04:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:58571 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932088AbWCNJEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 04:04:21 -0500
X-Authenticated: #14349625
Subject: Re: Which kernel is the best for a small linux system?
From: Mike Galbraith <efault@gmx.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060314072921.GA13969@elte.hu>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
	 <1142237867.3023.8.camel@laptopd505.fenrus.org>
	 <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com>
	 <1142273212.3023.35.camel@laptopd505.fenrus.org>
	 <20060314062144.GC21493@w.ods.org>  <20060314072921.GA13969@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 10:05:30 +0100
Message-Id: <1142327130.8075.30.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 08:29 +0100, Ingo Molnar wrote:
> * Willy Tarreau <willy@w.ods.org> wrote:
> 
> > scheduler is still a big problem. Not only we occasionally see people 
> > complaining about unfair CPU distribution across processes (may be 
> > fixed now), but the scheduler still gives a huge boost to I/O 
> > intensive tasks which do lots of select() with small time-outs, which 
> > makes it practically unusable in network-intensive environments. I've 
> > observed systems on which it was nearly impossible to log in via SSH 
> > because of this, and I could reproduce the problem locally to create a 
> > local DoS where a single user could prevent anybody from logging in.  
> > 2.6.15 has improved a lot on this (pauses have reduced from 35 seconds 
> > to 4 seconds) but it's still not very good.

Hi Willy,

BTW, if you try my stuff, it'd be good to try just the "cleanup" patch
first.  It seems very likely to me that your problem is mostly caused by
the sleep_avg multiplier.  If the first patch cures your woes, try
killing just the multiplier in virgin source.

	-Mike

(oh yeah, the pipe patch is more or less meaningless now, ignore it)

