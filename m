Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTIVG3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTIVG3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:29:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:39618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263017AbTIVG3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:29:34 -0400
Date: Sun, 21 Sep 2003 23:31:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 - 3 New warnings (gcc 3.2.2)
Message-Id: <20030921233108.4b2164f8.akpm@osdl.org>
In-Reply-To: <200309220615.h8M6Ff5Q031500@cherrypit.pdx.osdl.net>
References: <200309220615.h8M6Ff5Q031500@cherrypit.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Cherry <cherry@osdl.org> wrote:
>
> fs/smbfs/proc.c:216: warning: initialization from incompatible pointer type
>  fs/smbfs/proc.c:217: warning: initialization from incompatible pointer type

doh.

--- 25-power4/fs/smbfs/proc.c~smbfs-nls-fix	2003-09-21 23:29:42.000000000 -0700
+++ 25-power4-akpm/fs/smbfs/proc.c	2003-09-21 23:30:17.000000000 -0700
@@ -212,12 +212,9 @@ static int char2uni(const unsigned char 
 }
 
 static struct nls_table unicode_table = {
-	"unicode",
-	uni2char,
-	char2uni,
-	NULL,		/* not used by smbfs */
-	NULL,
-	NULL,		/* not a module */
+	.charset	= "unicode",
+	.uni2char	= uni2char,
+	.char2uni	= char2uni,
 };
 
 /* ----------------------------------------------------------- */

_

