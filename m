Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271283AbTHCVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTHCVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:49:16 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:40168 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271283AbTHCVsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:48:05 -0400
From: Miles Lane <miles.lane@comcast.net>
To: Gergely Nagy <algernon@bonehunter.rulez.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [TRIVIAL] compile fix for arch/ppc/kernel/setup.c
Date: Sun, 3 Aug 2003 14:47:55 -0700
User-Agent: KMail/1.5.9
References: <20030803204138.GB18494@gandalph.mad.hu>
In-Reply-To: <20030803204138.GB18494@gandalph.mad.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308031447.55659.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun August 3 2003 1:41 pm, Gergely Nagy wrote:
> Hi!
>
> I'm posting both to linuxppc-dev and lkml, since the latter is listed in
> MAINTAINERS. I've been trying to get my PowerMac 4400 boot with linux
> 2.6.0-test2(-bk3), but the compile failed quite early in
> arch/ppc/kernel/setup.c. After adding an #include <linux/cpu.h>, it
> compiled. Patch is included below.
>
> --- arch/ppc/kernel/setup.c.old	2003-08-03 22:35:51.000000000 +0200
> +++ arch/ppc/kernel/setup.c	2003-08-03 22:35:41.000000000 +0200
> @@ -2,6 +2,7 @@
>   * Common prep/pmac/chrp boot and setup code.
>   */
>
> +#include <linux/config.h>
>  #include <linux/cpu.h>
>  #include <linux/module.h>
>  #include <linux/string.h>
>
>
> --

Hmm.  This doesn't look like the correct patch.  This one shows linux/config.h 
being added, not linux/cpu.h.  How about this one, instead?

--- arch/ppc/kernel/setup.c~    2003-08-03 10:46:40.000000000 -0700
+++ arch/ppc/kernel/setup.c     2003-08-03 10:48:04.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/cpu.h>

 #include <asm/residual.h>
 #include <asm/io.h>
