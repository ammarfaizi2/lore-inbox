Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUH0Nzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUH0Nzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUH0Nzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:55:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29140 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263851AbUH0Nzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:55:41 -0400
Date: Fri, 27 Aug 2004 09:03:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com
Subject: Re: [2.4 patch][1/6] ibmphp_res.c: fix gcc 3.4 compilation
Message-ID: <20040827120330.GD32707@logos.cnet>
References: <20040826195133.GB12772@fs.tum.de> <20040826195455.GC12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195455.GC12772@fs.tum.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 09:54:55PM +0200, Adrian Bunk wrote:
> I got the following compile error when trying to build 2.4.28-pre2 using 
> gcc 3.4:
> 
> <--  snip  -->
> 
> ...
> gcc-3.4 -D__KERNEL__ 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -fno-unit-at-a-time  -D_LINUX 
> -I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/drivers/acpi  
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=ibmphp_res  -c -o 
> ibmphp_res.o ibmphp_res.c
> ibmphp_res.c: In function `ibmphp_rsrc_init':
> ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
> 'find_bus_wprev': function body not available
> ibmphp_res.c:237: sorry, unimplemented: called from here
> ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
> 'find_bus_wprev': function body not available
> ibmphp_res.c:261: sorry, unimplemented: called from here
> ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
> 'find_bus_wprev': function body not available
> ibmphp_res.c:284: sorry, unimplemented: called from here
> make[3]: *** [ibmphp_res.o] Error 1
> make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/drivers/hotplug'
> 
> <--  snip  -->
> 
> 
> The patch below fixes this issue by uninlining find_bus_wprev (as done 
> in 2.6).

Just out of curiosity, if you move the inlined function up to the beginning of the 
file (before any calls to it), and remove the declaration (at 45), does it
stop complaining?
