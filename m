Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVDEQ4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVDEQ4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVDEQwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:52:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:666 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261823AbVDEQsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:47 -0400
Date: Tue, 5 Apr 2005 09:48:15 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: blaisorblade@yahoo.it, jdike@karaya.com
Subject: [08/08] uml: va_copy fix
Message-ID: <20050405164815.GI17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

Uses __va_copy instead of va_copy since some old versions of gcc (2.95.4
for instance) don't accept va_copy.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 clean-linux-2.6.11-paolo/arch/um/kernel/skas/uaccess.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/skas/uaccess.c~uml-va_copy_fix arch/um/kernel/skas/uaccess.c
--- clean-linux-2.6.11/arch/um/kernel/skas/uaccess.c~uml-va_copy_fix	2005-04-01 22:37:11.000000000 +0200
+++ clean-linux-2.6.11-paolo/arch/um/kernel/skas/uaccess.c	2005-04-01 22:37:11.000000000 +0200
@@ -61,7 +61,8 @@ static void do_buffer_op(void *jmpbuf, v
 	void *arg;
 	int *res;
 
-	va_copy(args, *(va_list *)arg_ptr);
+	/* Some old gccs recognize __va_copy, but not va_copy */
+	__va_copy(args, *(va_list *)arg_ptr);
 	addr = va_arg(args, unsigned long);
 	len = va_arg(args, int);
 	is_write = va_arg(args, int);
_

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable

