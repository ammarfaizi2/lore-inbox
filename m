Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965355AbWAFXuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965355AbWAFXuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbWAFXuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:50:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965355AbWAFXuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:50:16 -0500
Date: Fri, 6 Jan 2006 15:52:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: kiran@scalex86.org, oleg@tv-sign.ru, shai@scalex86.org,
       nippung@calsoftinc.com, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single
 threadedprocess at getrusage()
Message-Id: <20060106155203.3e05d3ce.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com>
References: <43AD8AF6.387B357A@tv-sign.ru>
	<Pine.LNX.4.62.0512271220380.27174@schroedinger.engr.sgi.com>
	<43B2874F.F41A9299@tv-sign.ru>
	<20051228183345.GA3755@localhost.localdomain>
	<20051228225752.GB3755@localhost.localdomain>
	<43B57515.967F53E3@tv-sign.ru>
	<20060104231600.GA3664@localhost.localdomain>
	<43BD70AD.21FC6862@tv-sign.ru>
	<20060106094627.GA4272@localhost.localdomain>
	<Pine.LNX.4.62.0601060921530.17444@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Fri, 6 Jan 2006, Ravikiran G Thirumalai wrote:
> 
> > +	need_lock = !(p == current && thread_group_empty(p));
> 
> Isnt 
> 
> need_lock = (p != current || !thread_group_empty(b))
> 
> clearer?

I was actually going to change it to

	if (p != current || !thread_group_empty(p))
		need_lock = 1;

a) because my brain works that way and 

b) To make the currently-unneeded initialisation of need_lock do
   something useful ;)

