Return-Path: <linux-kernel-owner+willy=40w.ods.org-S289366AbUKBHvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S289366AbUKBHvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUKBHvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:51:20 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:52102 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S289366AbUKBHuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:50:50 -0500
Date: Tue, 2 Nov 2004 02:46:35 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 504] m68k: smp_lock.h: Avoid recursive include
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <200411020249_MC3-1-8DAD-7CF5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> This one is _totally_ broken. 
> 
> Not only is that include not recursive, but it immediately breaks any SMP 
> compile because that header file _needs_ the definition of "task_struct".
>
>
> On Sun, 31 Oct 2004, Geert Uytterhoeven wrote:
> >
> > smp_lock.h: Avoid recursive include
> > 
> > --- linux-2.6.10-rc1/include/linux/smp_lock.h       2004-04-28 15:47:31.000000000 +0200
> > +++ linux-m68k-2.6.10-rc1/include/linux/smp_lock.h  2004-10-20 22:24:05.000000000 +0200
> > @@ -2,7 +2,6 @@
> >  #define __LINUX_SMPLOCK_H
> >  
> >  #include <linux/config.h>
> > -#include <linux/sched.h>


Shouldn't you also revert cset 1.2405, also by Geert, which added
<linux/sched.h> to reiserfs_fs.h?  Looks like that was done to fix
breakage caused by this change.


--Chuck Ebbert  02-Nov-04  03:48:03
