Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263696AbUJ3AVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbUJ3AVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUJ3AUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:20:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:6108 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263696AbUJ3ABa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:01:30 -0400
Date: Fri, 29 Oct 2004 17:01:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: Steven Dake <sdake@mvista.com>
Cc: Chris Wright <chrisw@osdl.org>, Mark Haverkamp <markh@osdl.org>,
       Openais List <openais@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 kernel oops with openais
Message-ID: <20041029170129.W2357@build.pdx.osdl.net>
References: <1099090282.14581.19.camel@persist.az.mvista.com> <1099091302.13961.42.camel@markh1.pdx.osdl.net> <1099091816.14581.22.camel@persist.az.mvista.com> <20041029163944.H14339@build.pdx.osdl.net> <1099093468.1207.8.camel@persist.az.mvista.com> <20041029164551.U2357@build.pdx.osdl.net> <1099094226.1207.13.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099094226.1207.13.camel@persist.az.mvista.com>; from sdake@mvista.com on Fri, Oct 29, 2004 at 04:57:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Dake (sdake@mvista.com) wrote:
> The change was that from 2.6.8 to 2.6.9 the rlimit for memlock was
> changed from infinity to 32k (and at the same time, normal users are now
> allowed to use mlockall if they dont have alot of memory to mlock).  I
> fixed up the openais code by doing something evil from uid 0 like:
> 
>        struct rlimit rlimit;
> 
>         rlimit.rlim_cur = RLIM_INFINITY;
>         rlimit.rlim_max = RLIM_INFINITY;
>         setrlimit (RLIMIT_MEMLOCK, &rlimit);

Yeah, that'll do it (although, certainly wouldn't hurt to size it
down ;-).  Hopefully most users aren't dropping uid (I doubt it, since
I hadn't seen this problem pop up before).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
