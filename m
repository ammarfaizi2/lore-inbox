Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUHHXGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUHHXGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 19:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbUHHXGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 19:06:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:34749 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265517AbUHHXGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 19:06:35 -0400
Date: Sun, 8 Aug 2004 16:04:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-Id: <20040808160456.7706bc97.akpm@osdl.org>
In-Reply-To: <20040808225504.GD31602@ens-lyon.fr>
References: <20040808152936.1ce2eab8.akpm@osdl.org>
	<20040808225504.GD31602@ens-lyon.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
>
> I got this compile error on my Compaq Evo N600c. .config is attached.
> 
>  CC      arch/i386/kernel/nmi.o
>    arch/i386/kernel/nmi.c: In function proc_unknown_nmi_panic':
>    arch/i386/kernel/nmi.c:558: error: too few arguments to function proc_dointvec'
>  make[1]: *** [arch/i386/kernel/nmi.o] Erreur 1

uh, OK.  The below is probably wrongish, but it'll get you thorugh.


diff -puN arch/i386/kernel/nmi.c~nmi-build-fix arch/i386/kernel/nmi.c
--- 25/arch/i386/kernel/nmi.c~nmi-build-fix	2004-08-08 16:03:28.141725080 -0700
+++ 25-akpm/arch/i386/kernel/nmi.c	2004-08-08 16:04:13.168879912 -0700
@@ -555,7 +555,7 @@ int proc_unknown_nmi_panic(ctl_table *ta
 	int old_state;
 
 	old_state = unknown_nmi_panic;
-	proc_dointvec(table, write, file, buffer, length);
+	proc_dointvec(table, write, file, buffer, length, &file->f_pos);
 	if (!!old_state == !!unknown_nmi_panic)
 		return 0;
 
_

