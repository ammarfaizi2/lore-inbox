Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270446AbTGSS0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTGSS0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:26:20 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:51876 "HELO
	develer.com") by vger.kernel.org with SMTP id S270446AbTGSSZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:25:58 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: Valdis.Kletnieks@vt.edu, Christoph Hellwig <hch@infradead.org>
Subject: Re: [TRIVIAL] fix include/linux/sysctl.h for userland
Date: Sat, 19 Jul 2003 20:40:49 +0200
User-Agent: KMail/1.5.9
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200307191952.35499.bernie@develer.com> <200307191801.h6JI1VbF012692@turing-police.cc.vt.edu>
In-Reply-To: <200307191801.h6JI1VbF012692@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307192040.49258.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003 19:52:35 +0200, Bernardo Innocenti said:
> > Include linux/compiler.h in include/linux/sysctl.h. Needed to get __user
> > defined when C library uses this header (ie: no __KERNEL__).

On Saturday 19 July 2003 20:01, Valdis.Kletnieks@vt.edu wrote:
> Umm... shouldn't this be in the glibc-kernheaders version of sysctl.h
> that ends up in /usr/include rather than the kernel version?

On Saturday 19 July 2003 19:59, Christoph Hellwig wrote:
> It shouldn't be included from userspace, and glibc needs to be fixed not
> to do so.

Two reasons:

 - I'm using uClibc, not glibc. uClibc doesn't have a fixed copy
   of the kernel headers. Everything builds fine with real kernel
   headers from both 2.4.x and 2.6.x, except for this small glitch.

 - If we fix it now, the glibc guys will have one less patch to
   apply when they update their copy.

The glibc-kernelheaders package exists only because the glibc
people cannot afford to work-around every single quirk in any
version of the kernel.

And if you often build system utilities you'll find out there is
quite a lot of userland code out there with legitimate reasons
for including kernel headers. Some examples: strace, nfsutils,
psutils, quota.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


