Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSEYIJC>; Sat, 25 May 2002 04:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSEYIJB>; Sat, 25 May 2002 04:09:01 -0400
Received: from surf.viawest.net ([216.87.64.26]:16540 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S314085AbSEYIJA>;
	Sat, 25 May 2002 04:09:00 -0400
Date: Sat, 25 May 2002 01:08:58 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.18 -- build failure -- suspend.c:1052: dereferencing pointer to incomplete type
Message-ID: <20020525080858.GA26997@wizard.com>
In-Reply-To: <3CEF2DAA.8030902@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 1:01am  up 2 days, 10:15,  2 users,  load average: 0.32, 0.33, 0.15
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 11:22:34PM -0700, Miles Lane wrote:
> I have included the error, the output of ver_linux and
> snippets of .config.
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.18/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=athlon
>  -DKBUILD_BASENAME=suspend -DEXPORT_SYMTAB -c -o suspend.o suspend.c
> suspend.c: In function `freeze_processes':
> suspend.c:240: warning: implicit declaration of function `signal_wake_up'
> suspend.c: In function `fill_suspend_header':
> suspend.c:292: warning: comparison between pointer and integer

 [ snip ]
 
> I don't know what options might be involved in causing this build
> failure, so I will only include some of the higher level ones:

> CONFIG_SOFTWARE_SUSPEND=y
  ^^^^^^^^^^^^^^^^^^^^^^^^^

        This, I believe is what is causing it. in looking through the 2.5.18 
patch, this is new to the kernel, and is a newly configurable option to the 
kernel. For testing, I could see you adding it in, but you need this? 
especially if you have APM or ACPI? This doesn't rely on those, but if you're 
using APM or ACPI for suspend, this really wouldn't be needed.

                                                        BL. 
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

