Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWEMXSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWEMXSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWEMXSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:18:36 -0400
Received: from canuck.infradead.org ([205.233.218.70]:59578 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964793AbWEMXSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:18:36 -0400
Subject: Re: [PATCH] mtd: fix memory leaks in phram_setup
From: David Woodhouse <dwmw2@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org,
       Jochen =?ISO-8859-1?Q?Sch=E4uble?= <psionic@psionic.de>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200605140107.18293.jesper.juhl@gmail.com>
References: <200605140107.18293.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 00:18:20 +0100
Message-Id: <1147562300.12379.1.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 01:07 +0200, Jesper Juhl wrote:
> There are two code paths in drivers/mtd/devices/phram.c::phram_setup() that
> will leak memory.
> Memory is allocated to the variable 'name' with kmalloc() by the 
> parse_name() function, but if we leave by way of the parse_err() macro, 
> then that memory is never kfree()'d, nor is it ever used with 
> register_device() so it won't be freed later either - leak.
> 
> Found by the Coverity checker as #593 - simple fix below.

Applied; thanks. Please Cc me and/or linux-mtd@lists.infradead.org on
MTD patches.

(Ew. The parse_err() macro contains a 'return'. Who do I slap for that?)

-- 
dwmw2

