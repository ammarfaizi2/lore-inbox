Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVAHXnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVAHXnu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 18:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVAHXnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 18:43:49 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:36618 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262139AbVAHXnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 18:43:42 -0500
Date: Sun, 9 Jan 2005 00:43:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/block/ps2esdi.c: remove two unused functions (fwd)
Message-ID: <20050108234337.GE6052@pclin040.win.tue.nl>
References: <20050108214036.GW14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108214036.GW14108@stusta.de>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 10:40:36PM +0100, Adrian Bunk wrote:
> The patch below still applies and compiles against 2.6.10-mm2.
> 
> Date:	Mon, 29 Nov 2004 13:35:00 +0100
> From: Adrian Bunk <bunk@stusta.de>
> To: linux-kernel@vger.kernel.org
> Subject: [2.6 patch] drivers/block/ps2esdi.c: remove two unused functions
> 
> The patch below removes two unused global functions.
> 
> --- linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c.old	2004-11-06 20:17:34.000000000 +0100
> +++ linux-2.6.10-rc1-mm3-full/drivers/block/ps2esdi.c	2004-11-06 20:18:33.000000000 +0100
...
> -void __init tp720_setup(char *str, int *ints)
> -{
...
> -
> -void __init ed_setup(char *str, int *ints)
> -{
...

Hmm. You remove the setup functions, but not the rest of the code.

Of course it is true that nobody uses these today.
On the other hand, I imagine that there was no conscious decision
to kill them. Patch 2.3.13 (August 1999) introduces the
__setup/__initcall setup, and Linus wrote

 "Ok, I finally did what I've wanted to do for a _loong_ time: get rid of
  the horrible #ifdef CONFIG_XXXX mess in init/main.c.
  ...
  I've fixed up a few of the old command lines and initialization functions,
  but I'm hoping that driver writers can re-instate their own setup
  functions rather than me trying to fix up them all by hand."

Many ancient drivers were broken, and perhaps nobody noticed.

For example, Documentation/kernel-parameters.txt tells us that we
can use tp720=, which is false today. It becomes true upon adding
a line

__setup("tp720=", tp720_setup)

and changing the tp720_setup prototype a little.
(Remove the int *ints, possibly add a call to get_options().)

Since there was no storm of complaints, it may be that we can just
remove all reference to tp720, possibly all of ps2esdi, and
similarly for xd. For the past few years the only discussions
have been about these not compiling and getting janitor-type fixes.

Is Paul Gortmaker the only Linux user who still uses this hardware?

Andries
