Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267542AbUHUR7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267542AbUHUR7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUHUR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:59:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:42725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267542AbUHUR7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:59:39 -0400
Date: Sat, 21 Aug 2004 10:49:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Timer allocates too many ports
Message-Id: <20040821104916.5f391e0c.rddunlap@osdl.org>
In-Reply-To: <41270EB4.5030104@drzeus.cx>
References: <4126600F.4050302@drzeus.cx>
	<20040820140503.67d23479.rddunlap@osdl.org>
	<41266C5D.7000908@drzeus.cx>
	<20040820144106.46fb3b1b.rddunlap@osdl.org>
	<41270EB4.5030104@drzeus.cx>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 10:58:28 +0200 Pierre Ossman wrote:

| Randy.Dunlap wrote:
| 
| >On Fri, 20 Aug 2004 23:25:49 +0200 Pierre Ossman wrote:
| >
| >
| >| I do not know which file contains this allocation so I haven't been able 
| >| to change it. Any ideas?
| >
| >Sure, arch/i386/kernel/setup.c, near line 221 (in 2.6.8.1):
| >
| >	.name	= "timer",
| >	.start	= 0x0040,
| >	.end	= 0x005f,
| >	.flags	= IORESOURCE_BUSY | IORESOURCE_IO
| >
| >Just split that into 2 entries in the standard_io_resources[] array
| >and it's done.
| >
| >  
| >
| Thanks. That worked perfectly. Who is the responsible maintainer for 
| this part of the kernel? When my driver is ready to be added to the 
| Linus' kernel I need to have this changed.

Post the patch here for other comments/review & copy it to akpm@osdl.org
(Andrew Morton).

He will likely merge it into the -mm patchset for a while to see if it
makes anything else unhappy.  If not, and if noone has problems with it
(e.g., on other kinds of x86 motherboards), then it should be
merged, but that's up to Andrew and/or Linus.

--
~Randy
