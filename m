Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTFFWYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTFFWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:24:40 -0400
Received: from fmr01.intel.com ([192.55.52.18]:9726 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262321AbTFFWYj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:24:39 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DA16960@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'dipankar@in.ibm.com'" <dipankar@in.ibm.com>
Cc: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: How to initialize complex per-cpu variables?
Date: Fri, 6 Jun 2003 13:44:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dipankar Sarma [mailto:dipankar@in.ibm.com]
> 
> On Thu, Jun 05, 2003 at 09:35:37PM +0000, Perez-Gonzalez, Inaky wrote:
> > Now the question is: how do I walk each structure that is
> > associated to each CPU - I mean, something like:
> >
> > struct rtf_h *h;
> > for_each_cpu (h, rtf_lh) {
> > 	rtf_h_init (h);
> > }
> 
> One way to do this would be to do -
> 
> for (i = 0; i < NR_CPUS; i++) {
> 	if (cpu_possible(i))
> 		rtf_h_init(&per_cpu(rtf_lh, i));
> }

Yeap, that is a way ...
 
> However you might want to actually use the CPU notifiers to do this. See
> rcu_init() in kernel/rcupdate.c.

Aha ... that is the bit I was missing - cool, thanks; the only thing,
although I don't think I will have a problem with it, is that the 
notifiers are going to be called before my __initcall, probably (or
even worse, there is no defined order) ... well, I don't think that
will be a problem.

Thanks so much,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
