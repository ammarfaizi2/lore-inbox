Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWADVXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWADVXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWADVXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:23:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965090AbWADVXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:23:11 -0500
Date: Wed, 4 Jan 2006 16:22:50 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060104212250.GC9754@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Con Kolivas <kernel@kolivas.org>, ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060104195726.GB14782@redhat.com> <1136406837.2839.67.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136406837.2839.67.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 09:33:56PM +0100, Arjan van de Ven wrote:

 > > Ah interesting. It needs to be totally idle for a period of time before
 > > anything starts to happen at all. After about a minute of doing nothing,
 > > it started to fluctuate once a second 20,21,19,20,19,20,18,21,19,20,22 etc..
 > 
 > 
 > sounds like we need some sort of profiler or benchmarker or at least a
 > tool that helps finding out which timers are regularly firing, with the
 > aim at either grouping them or trying to reduce their disturbance in
 > some form.

And the winner (by a *big* margin) is...

USB.

rh_timer_func() gets called quite a *lot*. (Looks like every 250ms)

cursor_timer_handler() too. *blinky blinky*

X causes lots of hits to it_real_fn()
(incidentally, the power fluctuation only happens when at the
 console. When in X, it never happens, so we're probably hitting
 this a little too often in that case).
		
lots of apps cause process_timeout to be hit frequently.

		Dave

