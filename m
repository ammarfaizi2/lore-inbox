Return-Path: <linux-kernel-owner+w=401wt.eu-S1030267AbXAKMii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbXAKMii (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbXAKMii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:38:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:55954 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030267AbXAKMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:38:37 -0500
Date: Thu, 11 Jan 2007 13:38:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Linus Torvalds <torvalds@osdl.org>
cc: Jean Delvare <khali@linux-fr.org>, Andrey Borzenkov <arvidjaar@mail.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
In-Reply-To: <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701111330400.14457@scrub.home>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 10 Jan 2007, Linus Torvalds wrote:

> This part:
> 
> 	const char __init linux_banner[] =
> 
> CANNOT work, because the stupid SuSE tool that look into the kernel binary 
> searches for "Linux version " as the thing, and as such the "linux_banner" 
> has to be the _first_ thing to trigger it for it to work.

Unless the SuSE tool is completely stupid, it should actually work:

$ strings vmlinux | grep "Linux version"
Linux version 2.6.20-rc3-git7 (roman@squid) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #7 SMP Wed Jan 10 14:20:10 CET 2007
$

> Which is why "__init" is wrong. It causes the linker to either put it at 
> the end of the thing (which would break the SuSE tool). Alternatively it 
> causes section mismatch problems ("init" and "const" don't work that well 
> together), in which case it might work, but only due to toolchain bugs.

The const could be dropped, but it shouldn't hurt much either...

bye, Roman
