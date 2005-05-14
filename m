Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVENRWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVENRWY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 13:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVENRWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 13:22:23 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:51850 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S262806AbVENRWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 13:22:18 -0400
Date: Sat, 14 May 2005 10:22:13 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux@dominikbrodowski.net
Subject: Re: [PATCH] pcmcia/ds: handle any error code
Message-Id: <20050514102213.3440c526.rdunlap@xenotime.net>
In-Reply-To: <20050513194549.GB3519@animx.eu.org>
References: <20050512015220.GA31634@animx.eu.org>
	<20050512230206.GA1380@animx.eu.org>
	<20050512222038.325081b2.rdunlap@xenotime.net>
	<20050513194549.GB3519@animx.eu.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 15:45:49 -0400 Wakko Warner wrote:

| randy_dunlap wrote:
| > On Thu, 12 May 2005 19:02:06 -0400 Wakko Warner wrote:
| > There is some small difference in locking in fs/char_dev.c between
| > 2.6.12-rc4 and 2.6.11.8, but I don't yet see why it would cause a
| > failure in register_chrdev().
| > 
| > Oh, there's a big difference in drivers/pcmcia/ds.c, lots of probe
| > changes.  This is where to look further (but not tonight).
| > The question then becomes is this a real regression?
| > 
| > Do you suspect a problem with -Os code generation?
| 
| I just tried it, it doesn't give me any errors.  This is strange considering
| that I a) use a pristine tree for each kernel (only coping the .config) and
| b) the patch doesn't do anything except report the error.  I made my boot
| floppy (the scripts I use pull from the kernel tree I specify and make the
| image I need) and booted from it.  I placed the modules on my stage2 disk
| that was made and it works.
| 
| I don't have the time this week to try again from scratch.  I'll see if I
| can do it next week.

I'm currently running a kernel built with -Os.  I can successfully
load pcmcia_core.ko and pcmcia.ko.  I added debug printk's in
drivers/pcmcia/ds.c and it allocates the dynamic major dev
successfully:
[4294809.055000] register_chrdev: returning 254
[4294809.060000] pcmcia major device = 254


What gcc version are you using?  (gcc 4.0 has a few known issues.)

---
~Randy
