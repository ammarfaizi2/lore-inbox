Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291473AbSBABea>; Thu, 31 Jan 2002 20:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291476AbSBABeV>; Thu, 31 Jan 2002 20:34:21 -0500
Received: from ns.suse.de ([213.95.15.193]:19729 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291473AbSBABeK>;
	Thu, 31 Jan 2002 20:34:10 -0500
Date: Fri, 1 Feb 2002 02:34:07 +0100
From: Dave Jones <davej@suse.de>
To: Nathan <wfilardo@fuse.net>, rml@tech9.net
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Various issues with 2.5.2-dj6
Message-ID: <20020201023407.K10343@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan <wfilardo@fuse.net>, rml@tech9.net,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C58B3DD.3000800@fuse.net> <20020131041901.H31313@suse.de> <3C59BA94.1050307@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C59BA94.1050307@fuse.net>; from wfilardo@fuse.net on Thu, Jan 31, 2002 at 04:43:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 04:43:48PM -0500, Nathan wrote:
 > > > Issue 2: Two IEEE1934 modules needed to have "#include 
 > > > <linux/interrupt.h>" added (host.c and another one I forget)
 > > Can you send the gcc error messages of these ?
 > > (A patch would be nice too)
 > >
 > GCC error messages:
 > 
 > gcc -D__KERNEL__ 
 > -I/home/expsoft/src/linux-kernel/linux-2.5/linux/include -Wall 
 > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
 > -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
 > -march=i686 -DMODULE -DMODVERSIONS -include 
 > /home/expsoft/src/linux-kernel/linux-2.5/linux/include/linux/modversions.h  
 > -DKBUILD_BASENAME=hosts  -c
 > -o hosts.o hosts.c
 > hosts.c: In function `hpsb_ref_host_Rsmp_b2d7a7ae':
 > hosts.c:53: `current' undeclared (first use in this function)
 > hosts.c:53: (Each undeclared identifier is reported only once
 > hosts.c:53: for each function it appears in.)
 > hosts.c:63: warning: implicit declaration of function 
 > `preempt_schedule_Rsmp_707f93dd'

 Looks like another preempt problem to me, as hosts.c doesn't
 reference current in my tree fwics.  The error on line 63
 looks suspect too.

 You may also get away with include sched.h instead of interrupt.h
 (which indirectly includes sched.h amongst other things).

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
