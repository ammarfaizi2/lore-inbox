Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269395AbUIIJnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269395AbUIIJnU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269399AbUIIJnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:43:20 -0400
Received: from [213.146.154.40] ([213.146.154.40]:35500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S269398AbUIIJnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:43:03 -0400
Subject: Re: What File System supports Application XIP
From: David Woodhouse <dwmw2@infradead.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: colin <colin@realtek.com.tw>, linux-kernel@vger.kernel.org
In-Reply-To: <4140200B.9060408@grupopie.com>
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
	 <4140200B.9060408@grupopie.com>
Content-Type: text/plain
Message-Id: <1094722976.4083.1550.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 09 Sep 2004 10:42:57 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 10:19 +0100, Paulo Marques wrote:
> colin wrote:
> > 
> > Hi there,
> > We are developing embedded Linux system. Performance is our consideration.
> > We hope some applications can run as fast as possible,
> > and are think if they can be put in a filesystem image, which resides in
> > RAM, and run in XIP (eXecute In Place)  manners.
> > I know that Cramfs has supported Application XIP. Is there any other FS that
> > also supports it? Ramdisk? Ramfs? Romfs?
> 
> Obvisously cramfs can not support XIP, because the "in-place" image
> is compressed (unless you have a processor that can execute compressed
> code :)

Actually there are hacks floating around which do let you use XIP with
cramfs -- obviously you have to dispense with compression for the files
you want to access that way.

You won't gain at runtime by using XIP though. Your code and data will
end up in RAM _whatever_ file system you use, and you'll be running from
page cache.

You may get a _slightly_ faster startup time after reboot if you use XIP
from flash, because it doesn't have to be loaded into RAM first. But
that comes at the cost of making it all a low slower during normal
operation -- it's a lot slower to fetch icache lines from flash than it
is from RAM.

Arjan's right -- you almost certainly don't really want XIP. 

-- 
dwmw2

