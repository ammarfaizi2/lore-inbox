Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUEQXEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUEQXEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUEQXEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 19:04:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:5061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262996AbUEQXEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 19:04:33 -0400
Date: Mon, 17 May 2004 16:05:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Picco <Robert.Picco@hp.com>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040517160508.63e1ddf0.akpm@osdl.org>
In-Reply-To: <40A93DA5.4020701@hp.com>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
	<40A93DA5.4020701@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco <Robert.Picco@hp.com> wrote:
>
> O.K.  Did this but had to add a writeq and readq for i386.

You implementation of these is private to hpet.c.  From what Jeff is
saying, it looks like it should be in include/asm-i386/io.h?

#ifndef readq
static unsigned long long __inline readq(void *addr)
{
	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
}
#endif

#ifndef writeq
static void __inline writeq(unsigned long long v, void *addr)
{
	writel(v & 0xffffffff, addr);
	writel(v >> 32, addr + 4);
}
#endif

