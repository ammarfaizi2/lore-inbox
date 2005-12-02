Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVLBDxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVLBDxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLBDxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:53:44 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29918 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750779AbVLBDxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:53:44 -0500
Date: Fri, 2 Dec 2005 04:53:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>
Subject: Re: [BUG] Variable stopmachine_state should be volatile
Message-ID: <20051202035336.GC1770@elf.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60067BE61C@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60067BE61C@scsmsx403.amr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Thanks. The functions are not performance sensitive, so 
> >atomic_t is ok. Here is the new patch.
> >
> 
> The only reason atomic_t will help in this case is because it uses volatile for internal counter, as it does nothing additional on atomic_read(). I don't get what is the issue with using volatile directly. May be I am missing something. Pavel can you elaborate please.
> 

Look at atomic_t again. It is definitely not "just volatile",
definitely not on non-i386 architectures.

> The code here is doing something like this
> 
> While (variable != specific_value)
> 	cpu_relax();

So either do 

while (variable != value)
	mb();

or better use atomic_t.

> So, making variable atomic or declaring variable as volatile should have the same impact here. Note there is only one CPU setting this variable and rest of the CPUs just read it.
> 
> If volatile is not good, probably we need to find something other than atomic as well.
> 

atomic_t works, is used across the kernel, and works on all
architectures. volatile int does not. Do not use it.

							Pavel
-- 
Thanks, Sharp!
