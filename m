Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268721AbUHaPY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268721AbUHaPY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 11:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268727AbUHaPX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 11:23:56 -0400
Received: from smtp2.ca.com ([141.202.248.13]:26887 "EHLO smtp2.ca.com")
	by vger.kernel.org with ESMTP id S268721AbUHaPWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 11:22:17 -0400
Subject: Re: [ANNOUNCE] Kernel Generalized Event Management
From: Bob Bennett <Robert.Bennett2@ca.com>
To: Chris Wright <chrisw@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       kgem-devel@lists.sourceforge.net
In-Reply-To: <20040830153942.C1973@build.pdx.osdl.net>
References: <Pine.LNX.4.58.0408301738310.22919@benro02lx.ca.com>
	 <20040830153942.C1973@build.pdx.osdl.net>
Content-Type: text/plain
Organization: Computer Associates International, Inc
Message-Id: <1093966183.22744.125.camel@benro02lx.ca.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 31 Aug 2004 11:29:43 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2004 15:22:15.0675 (UTC) FILETIME=[4BF52CB0:01C48F6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 18:39, Chris Wright wrote:

> So, why so much patch to do what's already available in the kernel?  With
> LSM, plus audit, you can generate events that userspace can consume via
> netlink w/out this /proc stuff, and sys_call_table symbol lookup stuff,
> the kernel hooks, etc.
> 
I am looking into netlink implementation.  If it performs better, there
is no reason not to use it.  My intention is to provide a method for
handling _synchronous_ event notification, in a general enough way so
that it can be useful to a variety of userspace applications, and be
reasonably simple for an app to use.  The /proc implementation filled
that need.  Additionally, with netlink, it looks like I will need a
dedicated kernel thread that receives responses on the socket and wakes
up waiting tasks.  

It appears that Robert Love's Kernel Events Layer project is attempting
to address a lot of these event management issues.  An alternative is to
build upon this project to support synchronous event handling as well as
the event broadcasting that it performs now. 

As for hooks, LSM and audit do provide all the callouts I need for
generating events in 2.6.  The module that did sys_call_table lookup was
developed for working with 2.4 kernels that don't have LSM patch
applied, and should not have been included in the 2.6 patch.   

thanks,
	Bob

> How about starting by showing exactly what pieces are missing in the
> kernel?  This looks like things that can easily be done using existing
> infrastructure.
> 
> thanks,
> -chris

