Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWBZUjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWBZUjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWBZUjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:39:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:56482 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750870AbWBZUjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:39:08 -0500
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for
	!MULTIPLATFORM
From: Dave Hansen <haveblue@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0602241054090.2981-100000@gate.crashing.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 12:38:54 -0800
Message-Id: <1140986335.8697.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 10:54 -0600, Kumar Gala wrote:
> +       if (strstr(cmd_line, "mem=")) {
> +               char *p, *q;
> +               unsigned long maxmem = 0;
> +
> +               for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
> +                       q = p + 4;
> +                       if (p > cmd_line && p[-1] != ' ')
> +                               continue;
> +                       maxmem = simple_strtoul(q, &q, 0);
> +                       if (*q == 'k' || *q == 'K') {
> +                               maxmem <<= 10;
> +                               ++q;
> +                       } else if (*q == 'm' || *q == 'M') {
> +                               maxmem <<= 20;
> +                               ++q;
> +                       } else if (*q == 'g' || *q == 'G') {
> +                               maxmem <<= 30;
> +                               ++q;
> +                       }
> +               }
> +               memory_limit = maxmem;
> +       } 

You may want to check out lib/cmdline.c's memparse() function.  I think
it does this for you.

-- Dave

