Return-Path: <linux-kernel-owner+w=401wt.eu-S932718AbXAJHeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbXAJHeo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 02:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbXAJHeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 02:34:44 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:1150 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932718AbXAJHen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 02:34:43 -0500
Date: Wed, 10 Jan 2007 08:34:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org
Subject: Re: .version keeps being updated
Message-Id: <20070110083445.31b79bab.khali@linux-fr.org>
In-Reply-To: <20070109215527.GA24318@dreamland.darkstar.lan>
References: <20070109102057.c684cc78.khali@linux-fr.org>
	<20070109215527.GA24318@dreamland.darkstar.lan>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Tue, 9 Jan 2007 22:55:27 +0100, Luca Tettamanti wrote:
> Jean Delvare <khali@linux-fr.org> ha scritto:
> > Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
> > an incremented version number, whether there has actually been any
> > change done to the code or configuration or not. This increases the
> > build time quite a bit.
> > 
> > I've tracked it down to include/linux/compile.h always being updated,
> > and this is because .version is updated. I couldn't find what is
> > causing .version to be updated each time though. Can anybody help
> > there? Was this change made on purpose or is this a bug which we should
> > fix?
> 
> kronos:~/src/linux-2.6.git$ cat ../linux-build-git/include/linux/compile.h
> /* This file is auto generated, version 14 */
> /* SMP PREEMPT */
> #define UTS_MACHINE "i386"
> #define UTS_VERSION "#14 SMP PREEMPT Tue Jan 9 22:45:18 CET 2007"
> #define LINUX_COMPILE_TIME "22:45:18"
> #define LINUX_COMPILE_BY "kronos"
> #define LINUX_COMPILE_HOST "dreamland.darkstar.lan"
> #define LINUX_COMPILE_DOMAIN "darkstar.lan"
> #define LINUX_COMPILER "gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-20)"
> 
> LINUX_COMPILE_TIME and UTS_VERSION differs at each rebuild. UTS_VERSION
> is responsible of rebuilding fs/proc/proc_misc.o; init/main.o uses just
> about everything, init/version.o requires UTS_VERSION.

That's not quite true, LINUX_COMPILE_TIME and UTS_VERSION are
explicitely excluded from the comparison when checking whether
linux/compile.h changed. This is done in scripts/mkcompile_h, and I
believe this part works properly. This script wasn't modified recently.

> I don't think it's a regression from earlier kernels though, is it?

It definitely is, which is why I am reporting it and am asking for it
to be fixed. I isolated the two responsible commits elsewhere in the
thread.

Thanks,
-- 
Jean Delvare
