Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJ1S5a>; Mon, 28 Oct 2002 13:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSJ1S5a>; Mon, 28 Oct 2002 13:57:30 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39376 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261442AbSJ1S53>;
	Mon, 28 Oct 2002 13:57:29 -0500
Message-ID: <3DBD88EA.7000402@us.ibm.com>
Date: Mon, 28 Oct 2002 10:58:50 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: mochel@osdl.org, alan@lxorguk.ukuu.org.uk, davej@suse.de,
       mjbligh@us.ibm.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DriverFS Topology + per-node (NUMA) meminfo
References: <Pine.LNX.4.44.0210211447110.983-100000@cherise.pdx.osdl.net>	<3DB476A1.3090307@us.ibm.com> <20021028140511.115b3bf8.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Mon, 21 Oct 2002 14:50:25 -0700
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
> 
>>[ patch ]
> 
> 
> This clashes with my "move cpu driverfs to generic code" patch.


Yes, yes it does.  It does a lot of similar things though.  My patch
does not take advantage of the DECLARE_PER_CPU macros, etc.  But it also 
offers node-topology info and per-node meminfo.  I'd like to see them 
work together.  Most of the conflict is simply in where we put the 
driverfs CPU code.  Your patch moves it (w/ additions) to kernel/cpu.c, 
whereas mine moves it (also w/ different additions) to 
drivers/base/cpu.c.  I think that the drivers/base is a bit more 
appropriate for the driverfs specific code (struct device_driver 
cpu_driver, the array of cpu_devices...).  Also, I made the registration 
routines arch-specific, because I figured that different architectures 
may want to add arch-specific info, and register devices at different 
times, in different orders, etc.  I also didn't incorporate the 
cpu_notifier stuff, which I should have.

What do you think of my patch (other than the obvious that it conflicts 
with yours)?

Cheers!

-Matt

