Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWAQKQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWAQKQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWAQKQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:16:04 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:12230 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932382AbWAQKQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:16:01 -0500
Date: Tue, 17 Jan 2006 19:15:55 +0900
To: ak@suse.de, linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 3/4] compact print_symbol() output
Message-ID: <20060117101555.GD19473@miraclelinux.com>
References: <20060117101339.GA19473@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117101339.GA19473@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- remove symbolsize field
- change offset format from hexadecimal to decimal

99.9% of the functions in my vmlinux are smaller than 10000 bytes.
Therefore call trace must be more compact.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
----

 kallsyms.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- 2.6-git/kernel/kallsyms.c.orig	2006-01-16 22:06:16.000000000 +0900
+++ 2.6-git/kernel/kallsyms.c	2006-01-16 22:09:52.000000000 +0900
@@ -237,7 +237,7 @@ int __print_symbol(const char *fmt, unsi
 	const char *name;
 	unsigned long offset, size;
 	char namebuf[KSYM_NAME_LEN+1];
-	char buffer[sizeof("%s+%#lx/%#lx [%s]") + KSYM_NAME_LEN +
+	char buffer[sizeof("%s+%ld [%s]") + KSYM_NAME_LEN +
 		    2*(BITS_PER_LONG*3/10) + MODULE_NAME_LEN + 1];
 
 	name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
@@ -246,10 +246,9 @@ int __print_symbol(const char *fmt, unsi
 		sprintf(buffer, "0x%lx", address);
 	else {
 		if (modname)
-			sprintf(buffer, "%s+%#lx/%#lx [%s]", name, offset,
-				size, modname);
+			sprintf(buffer, "%s+%ld [%s]", name, offset, modname);
 		else
-			sprintf(buffer, "%s+%#lx/%#lx", name, offset, size);
+			sprintf(buffer, "%s+%ld", name, offset);
 	}
 	return printk(fmt, buffer);
 }
