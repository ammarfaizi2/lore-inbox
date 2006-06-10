Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWFJWAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWFJWAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFJWAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:00:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750948AbWFJWAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:00:09 -0400
Subject: Re: [PATCH] jffs2: fix section mismatches
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <20060610132803.8909971c.rdunlap@xenotime.net>
References: <20060610132803.8909971c.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 23:00:17 +0100
Message-Id: <1149976818.18635.153.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 13:28 -0700, Randy.Dunlap wrote:
> Priority: not critical; makes init code discardable.
> 
> Fix section mismatch warnings:
> WARNING: fs/jffs2/jffs2.o - Section mismatch: reference
> to .init.text:jffs2_zlib_init from .text between
> 'jffs2_compressors_init' (at offset 0x546) and
> 'jffs2_compressors_exit' 

Some of this is already in -mm, isn't it?

I'm wary of this kind of change from drive-by patchers now -- I had to
commit two fixes recently to remove __exit from functions which are
actually called in the error case from the init function.

For those exit-and-error functions, I think we actually want an
__initexit marker. In the built-in case, it can actually be discarded
with the init code. In the modular case, it needs to be kept.

-- 
dwmw2

