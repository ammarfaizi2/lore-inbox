Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbRE3U14>; Wed, 30 May 2001 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbRE3U1q>; Wed, 30 May 2001 16:27:46 -0400
Received: from ns.bagley.org ([216.30.46.2]:50411 "HELO ns.bagley.org")
	by vger.kernel.org with SMTP id <S262019AbRE3U1h>;
	Wed, 30 May 2001 16:27:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15125.22457.579578.487040@ns.bagley.org>
Date: Wed, 30 May 2001 15:27:37 -0500 (CDT)
To: linux-kernel@vger.kernel.org
Subject: calculation of ac_mem (in BSD accounting) misleading?
From: Doug Bagley <doug@bagley.org>
X-Face: "|NaWfYJ-]P="T#?R.9}QgGuFXUd@3vi[.E2q-;"NV3+k_y@zreL2w^ts0XPXtt9^9{uQ@.cu2GgUgK9@HXC\a}Rtah}0'eT~>or7[~Hd?;!\Bpo#"3<S%YOu{cRbrw?={32$(5@e/te?nkrEUlsBoWC,+N1M&g{:ej9?$c*7W?>w>0a0ft-MvvZ
X-Mailer: VM 6.75 under 21.2  (beta43) "Terspichore" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm interested in understanding better why the value of ac_mem in the
BSD process accounting code (linux/kernel/acct.c) is calculated the
way it is.  My humble uninformed opinion is that it's current
definition is possibly misleading at best and mostly useless at worst.

As a little background:

 The comment in include/linux/acct.h says ac_mem is "Average Memory
 Usage".

 According to BSD sources, ac_mem in BSD looks like a time-averaged
 resident set size:

  acct.ac_mem = (r->ru_ixrss + r->ru_idrss + r->ru_isrss) / t;
  (http://minnie.tuhs.org/FreeBSD-srctree/newsrc/kern/kern_acct.c.html)

But the code in linux/kernel/acct.c indicates that ac_mem is simply the
vmsize (in KB) at the time acct_process() is called from do_exit().  It
does not appear to be an average, and IMHO, vmsize is nearly useless,
especially if one expects RSS.

Does it make sense to others that ac_mem should be changed to reflect
the resident set size?

Cheers,
Doug
