Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965011AbWD1AX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWD1AX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 20:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWD1AXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 20:23:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:12506 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965011AbWD1AXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 20:23:07 -0400
Date: Thu, 27 Apr 2006 17:21:29 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 17/24] Alpha: strncpy() fix
Message-ID: <20060428002129.GR18750@kroah.com>
References: <20060428001226.204293000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alpha-strncpy-fix.patch"
In-Reply-To: <20060428001557.GA18750@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

[PATCH] Alpha: strncpy() fix

As it turned out after recent SCSI changes, strncpy() was broken -
it mixed up the return values from __stxncpy() in registers $24 and $27.

Thanks to Mathieu Chouquet-Stringer for tracking down the problem
and providing an excellent test case.

Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/alpha/lib/strncpy.S |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16.11.orig/arch/alpha/lib/strncpy.S
+++ linux-2.6.16.11/arch/alpha/lib/strncpy.S
@@ -43,8 +43,8 @@ strncpy:
 
 	.align	4
 $multiword:
-	subq	$24, 1, $2	# clear the final bits in the prev word
-	or	$2, $24, $2
+	subq	$27, 1, $2	# clear the final bits in the prev word
+	or	$2, $27, $2
 	zapnot	$1, $2, $1
 	subq	$18, 1, $18
 
@@ -70,8 +70,8 @@ $multiword:
 	bne	$18, 0b
 
 1:	ldq_u	$1, 0($16)	# clear the leading bits in the final word
-	subq	$27, 1, $2
-	or	$2, $27, $2
+	subq	$24, 1, $2
+	or	$2, $24, $2
 
 	zap	$1, $2, $1
 	stq_u	$1, 0($16)

--
