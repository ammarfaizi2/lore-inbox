Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269991AbTGLIOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 04:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269993AbTGLIOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 04:14:36 -0400
Received: from aneto.able.es ([212.97.163.22]:29169 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S269991AbTGLIOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 04:14:33 -0400
Date: Sat, 12 Jul 2003 10:29:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre5 - unresolved in hfsplus
Message-ID: <20030712082915.GA2409@werewolf.able.es>
References: <Pine.LNX.4.55L.0307111705090.5422@freak.distro.conectiva> <3F0F6B86.46FF4A6A@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3F0F6B86.46FF4A6A@eyal.emu.id.au>; from eyal@eyal.emu.id.au on Sat, Jul 12, 2003 at 03:59:34 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.12, Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> > Here goes -pre5.
> > J. A. Magallon:
> >   o hfsplus: group Apple FS's and help text
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-pre5/kernel/fs/hfsplus/hfsplus.o
> depmod:         mark_page_accessed
> 

I did not touch the code, I suppose nobody has tried to build it as a module.
Try with this...

--- mm/filemap.c.orig	2003-07-12 10:24:55.000000000 +0200
+++ mm/filemap.c	2003-07-12 10:25:17.000000000 +0200
@@ -1338,6 +1338,8 @@
 		SetPageReferenced(page);
 }
 
+EXPORT_SYMBOL(mark_page_accessed);
+
 /*
  * This is a generic file read routine, and uses the
  * inode->i_op->readpage() function for the actual low-level


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
