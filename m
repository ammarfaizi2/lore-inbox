Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTACH2f>; Fri, 3 Jan 2003 02:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbTACH2f>; Fri, 3 Jan 2003 02:28:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:55009 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267446AbTACH2f>;
	Fri, 3 Jan 2003 02:28:35 -0500
Message-ID: <3E153D99.58D95C0F@digeo.com>
Date: Thu, 02 Jan 2003 23:36:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brad Hards <bhards@bigpond.net.au>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Deprecate exec_usermodehelper, fix request_module.
References: <20030103050859.4E01B2C070@lists.samba.org> <200301031722.03325.bhards@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 07:36:58.0361 (UTC) FILETIME=[E59C9E90:01C2B2FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Fri, 3 Jan 2003 16:08, Rusty Russell wrote:
> > + * Must be called from process context.  Returns a negative error code
> > + * if program was not execed successfully, or (exitcode << 8 + signal)
> > + * of the application (0 if wait is not set).
> Any chance that you can remove this (existing) restriction. It'd be good to be
> able to use this in some networking code (eg netif_carrier_[off|on]() ), but
> that might be in interrupt context.
> 
> It may be just a matter of duplicating the arguments, but I really know SFA
> about this stuff, and am loath to touch it least it turn to mush in my
> fingers.
> 

I vaguely seem to recall having done that once.

It wasn't very pretty:

	int gfp_flags = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL; 

Patch against 2.4.0-test13 is at http://www.zip.com.au/~akpm/linux/1.txt
