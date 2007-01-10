Return-Path: <linux-kernel-owner+w=401wt.eu-S964964AbXAJRKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbXAJRKs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbXAJRKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:10:48 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:4466 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964964AbXAJRKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:10:47 -0500
Date: Wed, 10 Jan 2007 18:10:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-Id: <20070110181053.3b3632a8.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0701101426400.14458@scrub.home>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109170550.AFEF460C343@tzec.mtu.ru>
	<20070109214421.281ff564.khali@linux-fr.org>
	<Pine.LNX.4.64.0701101426400.14458@scrub.home>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Wed, 10 Jan 2007 14:45:28 +0100 (CET), Roman Zippel wrote:
> On Tue, 9 Jan 2007, Jean Delvare wrote:
> 
> > I tried a git bisect to find out what commit was reponsible for it, and
> > the winner is...
> > 
> > 8993780a6e44fb4e7ed34e33458506a775356c6e is first bad commit
> > commit 8993780a6e44fb4e7ed34e33458506a775356c6e
> > Author: Linus Torvalds <torvalds@woody.osdl.org>
> > Date:   Mon Dec 11 09:28:46 2006 -0800
> > 
> > [..]
> > Reverting this from 2.6.20-rc1 made the build behave again, however I
> > found that reverting it from 2.6.20-rc2 did _not_ fix the problem. I
> > also had to revert the following patch to make things work as before
> > again:
> > 
> > commit ef129412b4cbd6686d0749612cb9b76e207271f4
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Fri Dec 22 01:12:01 2006 -0800
> 
> To make the list complete, this patch started all the mess:
> 
> commit a2ee8649ba6d71416712e798276bf7c40b64e6e5
> Author: Herbert Poetzl <herbert@13thfloor.at>
> Date:   Fri Dec 8 02:36:00 2006 -0800
> 
>     [PATCH] Fix linux banner utsname information
> 
> and this tries to fix a problem in Andrew's patch:
> 
> commit d449db98d5d7d90f29f9f6e091b0e1d996184df1
> Author: Mikael Pettersson <mikpe@it.uu.se>
> Date:   Fri Dec 29 16:48:09 2006 -0800
> 
>     [PATCH] fix mrproper incompleteness
> 
> The patch below reverts pretty much everything and instead introduces a 
> seperate format string for proc.
> (...)
> [PATCH] fix linux banner format string
> 
> Revert previous attempts at messing with the linux banner string and 
> simply use a separate format string for proc.

This fixes the problem I reported. Thanks Roman!

Linus, Andrew, if Roman's patch looks OK to you, can it please be
applied before 2.6.20 is released?

Thanks,
-- 
Jean Delvare
