Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUJ3Ad0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUJ3Ad0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbUJ3AaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:30:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:3816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263701AbUJ3ATi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:19:38 -0400
Date: Fri, 29 Oct 2004 17:19:35 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Dake <sdake@mvista.com>
Cc: Chris Wright <chrisw@osdl.org>, Mark Haverkamp <markh@osdl.org>,
       Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 kernel oops with openais
Message-ID: <20041029171935.X2357@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com> <1099091302.13961.42.camel@markh1.pdx.osdl.net> <1099091816.14581.22.camel@persist.az.mvista.com> <20041029163944.H14339@build.pdx.osdl.net> <1099093468.1207.8.camel@persist.az.mvista.com> <20041029164551.U2357@build.pdx.osdl.net> <1099094226.1207.13.camel@persist.az.mvista.com> <20041029170129.W2357@build.pdx.osdl.net> <1099095114.1207.16.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099095114.1207.16.camel@persist.az.mvista.com>; from sdake@mvista.com on Fri, Oct 29, 2004 at 05:11:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Dake (sdake@mvista.com) wrote:
> What would be preferrable instead of dropping UID when privleged
> services are needed?  more specifically I need
>     * CAP_NET_RAW (bindtodevice)
>      * CAP_SYS_NICE (setscheduler)
>      * CAP_IPC_LOCK (mlockall)

You could drop all but those specific capabilities.  But, since you only
seem to need those during startup there's not a huge value in doing
anything other than what you're already doing.

> I had thought about adding the correct code to get these capabilities
> but it still requires a start-from-uid0 environment

Dropping uid is a fine idea, esp. since you have to start from uid 0
to get the bind/setsched/mlock bits done.  It just exposes a case where
the mlock change might surprise users, which is why I hope it's not the
common usage pattern (and I think most are root apps, so we should be ok).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
