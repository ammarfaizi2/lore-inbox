Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVCKRZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVCKRZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCKRZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:25:10 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:1468 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261219AbVCKRY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:24:59 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Export gcov symbol based on gcc version
Date: Fri, 11 Mar 2005 18:01:29 +0100
User-Agent: KMail/1.7.2
Cc: Adrian Bunk <bunk@stusta.de>, Jeff Dike <jdike@addtoit.com>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200503100216.j2A2G2DN015232@ccure.user-mode-linux.org> <20050310225340.GD3205@stusta.de>
In-Reply-To: <20050310225340.GD3205@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503111801.29510.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 March 2005 23:53, Adrian Bunk wrote:
> On Wed, Mar 09, 2005 at 09:16:02PM -0500, Jeff Dike wrote:
> > The init function called by gcc when gcov is enabled is __gcov_init or
> > __bb_init_func, depending on the gcc version.  Anton is using 3.3.4 and
> > seeing __gcov_init.  I'm using 3.3.2 and seeing __bb_init_func, so we
> > need to close that gap a bit.
> >
> > Signed-off-by: Jeff Dike <jdike@addtoit.com>
> >
> > Index: linux-2.6.11/arch/um/kernel/gmon_syms.c
> > ===================================================================
> > --- linux-2.6.11.orig/arch/um/kernel/gmon_syms.c 2005-03-07
> > 10:53:03.000000000 -0500 +++
> > linux-2.6.11/arch/um/kernel/gmon_syms.c 2005-03-07 16:29:37.000000000
> > -0500 @@ -5,8 +5,14 @@
> >
> >  #include "linux/module.h"
> >
> > +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> > + (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4)
> >...
>
> This patch is still wrong.
>
> It seems my comment on this [1] was lost:
>
> <--  snip  -->
>
> This line has to be something like
>
> ( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
>    HEAVILY_PATCHED_SUSE_GCC )
>
> I hope SuSE has added some #define to distinguish what they call
> "gcc 3.3.4" from GNU gcc 3.3.4
"You hope" does not mean "it exists".
Secondly, the patch is wrong anyway, as I said elsewhere.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

