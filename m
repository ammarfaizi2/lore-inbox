Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWFJWmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWFJWmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 18:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWFJWmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 18:42:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:39355 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750786AbWFJWmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 18:42:11 -0400
Date: Sun, 11 Jun 2006 00:41:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] jffs2: fix section mismatches
Message-ID: <20060610224141.GA727@mars.ravnborg.org>
References: <20060610132803.8909971c.rdunlap@xenotime.net> <1149976818.18635.153.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149976818.18635.153.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 11:00:17PM +0100, David Woodhouse wrote:
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
> 
> I'm wary of this kind of change from drive-by patchers now -- I had to
> commit two fixes recently to remove __exit from functions which are
> actually called in the error case from the init function.
The check in modpost should have caught these and
flagged them?!?

> For those exit-and-error functions, I think we actually want an
> __initexit marker. In the built-in case, it can actually be discarded
> with the init code. In the modular case, it needs to be kept.
People have troubles enough getting it right today.
Just see the warnings that comes with an allmodconfig build.
So introducing more complexity for a corner case is not a good way
forward.

	Sam
