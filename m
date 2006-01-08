Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbWAHA3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWAHA3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 19:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbWAHA3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 19:29:04 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:9662 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030501AbWAHA3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 19:29:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=RdiIe0t6ink4oMxADZIrKnW4gKagfJ6c25Y3EE33PDZ5UFlXD2DEAc5v+5dIpBeu1Ak0OEYpxYo+7Q7b3kGx6dezNI6mLHahqIhENfk4bkJ8QdTDZCsOl7vwnnw+3cf101gZ11nwkUt1TgYUT5nxdv8pfrNKJFHU9nE8bF1QC70=
Date: Sun, 8 Jan 2006 03:45:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH -mm] fixup *at syscalls additions (alpha, sparc64)
Message-ID: <20060108004557.GA21553@mipter.zuzino.mipt.ru>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru> <20060107154842.5832af75.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107154842.5832af75.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Apply after dump_thread-cleanup.patch fixup.

--- linux-2.6.15-mm2/arch/alpha/kernel/osf_sys.c
+++ linux-1/arch/alpha/kernel/osf_sys.c
@@ -960,7 +960,7 @@ osf_utimes(char __user *filename, struct
 			return -EFAULT;
 	}
 
-	return do_utimes(filename, tvs ? ktvs : NULL);
+	return do_utimes(AT_FDCWD, filename, tvs ? ktvs : NULL);
 }
 
 #define MAX_SELECT_SECONDS \
--- linux-2.6.15-mm2/arch/sparc64/kernel/sys_sparc32.c
+++ linux-1/arch/sparc64/kernel/sys_sparc32.c
@@ -820,7 +820,7 @@ asmlinkage long sys32_utimes(char __user
 			return -EFAULT;
 	}
 
-	return do_utimes(filename, (tvs ? &ktvs[0] : NULL));
+	return do_utimes(AT_FDCWD, filename, (tvs ? &ktvs[0] : NULL));
 }
 
 /* These are here just in case some old sparc32 binary calls it. */

