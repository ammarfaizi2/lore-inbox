Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbTGIW7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbTGIW7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:59:13 -0400
Received: from aneto.able.es ([212.97.163.22]:43436 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S268701AbTGIW7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:59:12 -0400
Date: Thu, 10 Jul 2003 01:13:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] do_generic_direct_write: bad flag check
Message-ID: <20030709231348.GC18564@werewolf.able.es>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jul 10, 2003 at 00:24:40 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.10, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre4. It contains a lot of updates and fixes.
> 

--- linux-2.4.22-pre2-jam1/mm/filemap.c.orig	2003-06-28 01:55:36.000000000 +0200
+++ linux-2.4.22-pre2-jam1/mm/filemap.c	2003-06-28 01:55:45.000000000 +0200
@@ -3223,7 +3223,7 @@
 	if (err != 0 || count == 0)
 		goto out;
 
-	if (!file->f_flags & O_DIRECT)
+	if (!(file->f_flags & O_DIRECT))
 		BUG();
 
 	remove_suid(inode);

...but sure the fix in -ac is better.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
