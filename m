Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWFJX1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWFJX1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWFJX07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:26:59 -0400
Received: from xenotime.net ([66.160.160.81]:40352 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161053AbWFJX07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:26:59 -0400
Date: Sat, 10 Jun 2006 16:29:45 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] jffs2: fix section mismatches
Message-Id: <20060610162945.b8823f6e.rdunlap@xenotime.net>
In-Reply-To: <1149976818.18635.153.camel@shinybook.infradead.org>
References: <20060610132803.8909971c.rdunlap@xenotime.net>
	<1149976818.18635.153.camel@shinybook.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 23:00:17 +0100 David Woodhouse wrote:

> On Sat, 2006-06-10 at 13:28 -0700, Randy.Dunlap wrote:
> > Priority: not critical; makes init code discardable.
> > 
> > Fix section mismatch warnings:
> > WARNING: fs/jffs2/jffs2.o - Section mismatch: reference
> > to .init.text:jffs2_zlib_init from .text between
> > 'jffs2_compressors_init' (at offset 0x546) and
> > 'jffs2_compressors_exit' 
> 
> Some of this is already in -mm, isn't it?

Ack, one of them is, yes.  Sorry I missed it.

> I'm wary of this kind of change from drive-by patchers now -- I had to
> commit two fixes recently to remove __exit from functions which are
> actually called in the error case from the init function.

Surely those would have been caught with the modpost checker,
if the patch submitter(s) used it... ??
FWIW, I check the ones that I submit very carefully, but I too
can make mistakes.

> For those exit-and-error functions, I think we actually want an
> __initexit marker. In the built-in case, it can actually be discarded
> with the init code. In the modular case, it needs to be kept.

That sounds good, yes.

---
~Randy
