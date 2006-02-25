Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWBYHJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWBYHJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 02:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWBYHJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 02:09:59 -0500
Received: from ozlabs.org ([203.10.76.45]:3464 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932414AbWBYHJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 02:09:58 -0500
Subject: Re: 2.6.16-rc4-mm2: drivers/isdn/hysdn/hysdn_net.c module_param()
	compile error
From: Rusty Russell <rusty@rustcorp.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060225033855.GG3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
	 <20060225033855.GG3674@stusta.de>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 18:10:03 +1100
Message-Id: <1140851403.10212.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 04:38 +0100, Adrian Bunk wrote:
> On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc4-mm1:
> >...
> > +remove-module_parm.patch
> >...
> >  Current 2.6.16 queue.  Some of these are a bit questionable at this stage.
> >...
> 
> This causes the following compile error:

Thanks Adrian!

The hysdn_net driver #defines uint to "unsigned int" in a header.
Remove that: the typedefs in types.h have the same effect, without
breaking "uint" module_param.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hysdn/hysdn_defs.h working-2.6.16-rc4-MODULE_PARM-remove/drivers/isdn/hysdn/hysdn_defs.h
--- linux-2.6.16-rc4/drivers/isdn/hysdn/hysdn_defs.h	2005-08-29 14:39:36.000000000 +1000
+++ working-2.6.16-rc4-MODULE_PARM-remove/drivers/isdn/hysdn/hysdn_defs.h	2006-02-25 18:06:06.000000000 +1100
@@ -24,8 +24,6 @@
 /* storage type definitions */
 /****************************/
 #define uchar unsigned char
-#define uint unsigned int
-#define ulong unsigned long
 #define word unsigned short
 
 #include "ince1pc.h"

-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

