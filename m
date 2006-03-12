Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWCLWdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWCLWdU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWCLWdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:33:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWCLWdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:33:19 -0500
Date: Sun, 12 Mar 2006 14:30:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, suresh.b.siddha@intel.com, rajesh.shah@intel.com
Subject: Re: More than 8 CPUs detected and CONFIG_X86_PC cannot handle it on
 2.6.16-rc6
Message-Id: <20060312143053.530ef6c9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0603120256480.14567@bizon.gios.gov.pl>
	<20060311210353.7eccb6ed.akpm@osdl.org>
	<Pine.LNX.4.64.0603121202540.31039@bizon.gios.gov.pl>
	<20060312032523.109361c1.akpm@osdl.org>
	<Pine.LNX.4.64.0603121359540.31039@bizon.gios.gov.pl>
	<20060312073524.A9213@unix-os.sc.intel.com>
	<Pine.LNX.4.64.0603122206110.19689@bizon.gios.gov.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Oledzki <olel@ans.pl> wrote:
>
> > Actually, this warning should be seen on many other systems on well. We
>  > use the bigsmp when there _or_ more than 8 CPUs or CPU_HOTPLUG is used.
>  > So, in that sense the message is wrong, it should also have CPU_HOTPLUG in
>  > there. Or we should make CPU_HOTPLUG depend on GENERIC_ARCH or auto select
>  > GENERIC_ARCH with hotplug at the CONFIG level.
> 
>  Why? I have exactly 4 HT CPUs (2 cores), no more. I use CPU hotplug so I 
>  can disable or enable any of them when I want to. So, this is a classic 
>  SMP system and 2.6.15 is totally happy with this. Or is there any other 
>  (better?) way to disable/enable CPU (especially second logical CPU from 
>  HT) on running systems?

Maybe we should have:

	if (num_possible_cpus() <= 8)
		dont_do_any_of_that_stuff();

That's assuming that hotplug-cpu-capable platforms are correctly setting
cpu_possible_map.  Do they?
