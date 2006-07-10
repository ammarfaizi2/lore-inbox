Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWGJXbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWGJXbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWGJXbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:31:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20684 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965061AbWGJXbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:31:45 -0400
Subject: [HDRINSTALL 2/3] Remove asm/atomic.h from user visibility
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1152573909.25567.45.camel@shinybook.infradead.org>
References: <1152573909.25567.45.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 00:32:09 +0100
Message-Id: <1152574329.25567.55.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[HDRINSTALL] Remove asm/atomic.h from user visibility
    
This isn't suitable for userspace to see -- the kernel headers are not a
random library of stuff for userspace; they're only there to define the
kernel<->user ABI for system libraries and tools. Anything which _was_
abusing asm/atomic.h from userspace was probably broken anyway -- as it
often didn't even give atomic operation.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
index da163c1..bdb8b08 100644
--- a/include/asm-generic/Kbuild.asm
+++ b/include/asm-generic/Kbuild.asm
@@ -5,7 +5,7 @@ unifdef-y += a.out.h auxvec.h byteorder.
 	statfs.h termbits.h termios.h timex.h types.h unistd.h user.h
 
 # These really shouldn't be exported
-unifdef-y += atomic.h io.h
+unifdef-y += io.h
 
 # These probably shouldn't be exported
 unifdef-y += elf.h page.h

-- 
dwmw2

