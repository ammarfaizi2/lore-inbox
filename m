Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWBCNQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWBCNQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWBCNQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:16:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22419 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750770AbWBCNQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:16:23 -0500
Date: Fri, 3 Feb 2006 14:16:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060203131602.GD2972@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602030727.48855.nigel@suspend2.net> <200602022310.40783.rjw@sisk.pl> <200602031020.46641.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602031020.46641.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 03-02-06 10:20:42, Nigel Cunningham wrote:
> Hi.
> 
> On Friday 03 February 2006 08:10, Rafael J. Wysocki wrote:
> > On machines with less RAM suspend2 will probably be better
> > preformance-wise, and that may be more important than the flexibility.
> 
> Ok. So I bit the bullet and downloaded -mm4 to take a look at this interface 
> you're making, and I have a few questions:

Great, thanks.

> - It seems to be hardwired to use swap, but you talk about writing to a 
> network image above. In Suspend2, I just bmap whatever the storage is, and 
> then submit bios to read and write the data. Is anything like that possible 
> with this interface? (Could it be extended if not?)

No, it is not hardwired. There's special swap support, but you do not
need to use it.

> - Is there any way you could support doing a full image of memory with this 
> approach? Would you take patches?

Doing full image is certainly possible; it is not important if kernel
does the writing or userspace does it. Taking patches definitely
depends how they'd look like...

> - Does the data have to be transferred to userspace? Security and efficiency 
> wise, it would seem to make a lot more sense just to be telling the kernel 
> where to write things and let it do bio calls like I'm doing at the
> moment.

As far as I can see, transfering data to userspace and back does not
really cost much:

pavel@amd:~$ time head -c $[1024*1024*1024] < /dev/zero > /dev/null
0.16user 0.27system 0.43 (0m0.439s) elapsed 100.00%CPU

...2000MB/sec is the limit (thinkpad x32).
								Pavel
-- 
Thanks, Sharp!
