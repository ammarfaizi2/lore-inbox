Return-Path: <linux-kernel-owner+w=401wt.eu-S965031AbXAJTD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbXAJTD0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 14:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbXAJTD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 14:03:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43127 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031AbXAJTDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 14:03:25 -0500
Date: Wed, 10 Jan 2007 11:02:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
cc: Roman Zippel <zippel@linux-m68k.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <20070110181053.3b3632a8.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2007, Jean Delvare wrote:
> 
> This fixes the problem I reported. Thanks Roman!
> 
> Linus, Andrew, if Roman's patch looks OK to you, can it please be
> applied before 2.6.20 is released?

I applied it, but looking closer at it, it becomes clear that Roman didn't 
understand the problem with that patch.

This part:

	const char __init linux_banner[] =

CANNOT work, because the stupid SuSE tool that look into the kernel binary 
searches for "Linux version " as the thing, and as such the "linux_banner" 
has to be the _first_ thing to trigger it for it to work.

Which is why "__init" is wrong. It causes the linker to either put it at 
the end of the thing (which would break the SuSE tool). Alternatively it 
causes section mismatch problems ("init" and "const" don't work that well 
together), in which case it might work, but only due to toolchain bugs.

Grr.

		Linus
