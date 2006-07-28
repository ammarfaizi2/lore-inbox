Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWG1PgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWG1PgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWG1PgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:36:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:40610 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161105AbWG1PgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:36:11 -0400
Date: Fri, 28 Jul 2006 08:35:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
In-Reply-To: <1154067247.27297.104.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain> 
 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
 <1154067247.27297.104.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Thomas Gleixner wrote:

> If you need more info, I can add debugs. It happens every bootup.

Could you tell me why _spin_lock and _spin_unlock seem 
to be calling into the slab allocator? Also what is child_rip()? Cannot 
find that function upstream.

There should be no lock recursion here because we are talking about alien 
cache arrays on different nodes.
