Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263748AbUJ3AWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbUJ3AWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUJ3AV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:21:28 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:21359 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263677AbUJ3AL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:11:56 -0400
Subject: Re: 2.6.9 kernel oops with openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Chris Wright <chrisw@osdl.org>
Cc: Mark Haverkamp <markh@osdl.org>, Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029170129.W2357@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com>
	 <1099091302.13961.42.camel@markh1.pdx.osdl.net>
	 <1099091816.14581.22.camel@persist.az.mvista.com>
	 <20041029163944.H14339@build.pdx.osdl.net>
	 <1099093468.1207.8.camel@persist.az.mvista.com>
	 <20041029164551.U2357@build.pdx.osdl.net>
	 <1099094226.1207.13.camel@persist.az.mvista.com>
	 <20041029170129.W2357@build.pdx.osdl.net>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1099095114.1207.16.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 17:11:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What would be preferrable instead of dropping UID when privleged
services are needed?  more specifically I need
    * CAP_NET_RAW (bindtodevice)
     * CAP_SYS_NICE (setscheduler)
     * CAP_IPC_LOCK (mlockall)

I had thought about adding the correct code to get these capabilities
but it still requires a start-from-uid0 environment

THanks
-steve

On Fri, 2004-10-29 at 17:01, Chris Wright wrote:
> * Steven Dake (sdake@mvista.com) wrote:
> > The change was that from 2.6.8 to 2.6.9 the rlimit for memlock was
> > changed from infinity to 32k (and at the same time, normal users are now
> > allowed to use mlockall if they dont have alot of memory to mlock).  I
> > fixed up the openais code by doing something evil from uid 0 like:
> > 
> >        struct rlimit rlimit;
> > 
> >         rlimit.rlim_cur = RLIM_INFINITY;
> >         rlimit.rlim_max = RLIM_INFINITY;
> >         setrlimit (RLIMIT_MEMLOCK, &rlimit);
> 
> Yeah, that'll do it (although, certainly wouldn't hurt to size it
> down ;-).  Hopefully most users aren't dropping uid (I doubt it, since
> I hadn't seen this problem pop up before).
> 
> thanks,
> -chris

