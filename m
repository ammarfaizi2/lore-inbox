Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVFSJ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVFSJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 05:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVFSJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 05:58:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24078 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261299AbVFSJ6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 05:58:39 -0400
Date: Sun, 19 Jun 2005 10:58:33 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [patch 2.6.12] Add -Wno-pointer-sign to HOSTCFLAGS
Message-ID: <20050619105833.C6499@flint.arm.linux.org.uk>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>, kaos@ocs.com.au,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <200506190923.j5J9Nbq0011676@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200506190923.j5J9Nbq0011676@harpo.it.uu.se>; from mikpe@csd.uu.se on Sun, Jun 19, 2005 at 11:23:37AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2005 at 11:23:37AM +0200, Mikael Pettersson wrote:
> On Sun, 19 Jun 2005 11:50:03 +1000, Keith Owens wrote:
> >Compiling 2.6.12 with gcc 4.0.0 (FC4) gets lots of warnings for the
> >programs in the scripts directory.  Add -Wno-pointer-sign to HOSTCFLAGS
> >to suppress them.
> >
> >Signed-off-by: Keith Owens <kaos@ocs.com.au>
> >
> >Index: 2.6.12/Makefile
> >===================================================================
> >--- 2.6.12.orig/Makefile	2005-06-18 15:21:18.000000000 +1000
> >+++ 2.6.12/Makefile	2005-06-19 11:43:15.876218980 +1000
> >@@ -204,6 +204,8 @@ CONFIG_SHELL := $(shell if [ -x "$$BASH"
> > HOSTCC  	= gcc
> > HOSTCXX  	= g++
> > HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> >+# disable pointer signedness warnings in gcc 4.0
> >+HOSTCFLAGS += $(call cc-option,-Wno-pointer-sign,)
> > HOSTCXXFLAGS	= -O2
> 
> Please don't. Bogus code should be fixed, not hidden.

cc-option checks to see if the flag is supported by $(CC) which could
be a completely different compiler from $(HOSTCC).  Hence the above
can incorrectly supply/fail to supply the argument.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
