Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTFIHUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 03:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFIHUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 03:20:19 -0400
Received: from dp.samba.org ([66.70.73.150]:22404 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264279AbTFIHUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 03:20:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS 
In-reply-to: Your message of "Sat, 07 Jun 2003 18:22:39 +0200."
             <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl> 
Date: Mon, 09 Jun 2003 16:00:57 +1000
Message-Id: <20030609073355.E92DE2C390@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.SOL.4.30.0306071815120.6449-100000@mion.elka.pw.edu.pl> you write:
> -static inline void remove_proc_entry(const char *name, struct proc_dir_entry *parent) {};
> +#define remove_proc_entry(name, parent)	/* nothing */

> And you wil not have to readd #ifdef/#endif pair.
> 
> I've seen Sam's mail but this is generic solution to quiet compiler
> and will work for any remove_proc_entry() user.

And it'll leave unused warnings all over the place, meaning you have
to add __unused to all the callers.  Now gcc 3.3 will actually discard
those unused functions, this might be worth considering.

But if you're going to do that, make create_proc_entry etc *not*
return NULL if !CONFIG_PROC_FS, otherwise you need the #ifdef anyway.
This has been noted before.

Good luck!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
