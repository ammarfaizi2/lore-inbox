Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422791AbWA1CTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWA1CTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWA1CTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:19:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:60856 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422791AbWA1CTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:19:09 -0500
Date: Fri, 27 Jan 2006 18:18:12 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       shaohua.li@intel.com
Subject: [patch 1/6] setting irq affinity is broken in ia32 with MSI enabled
Message-ID: <20060128021812.GB10362@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="setting-irq-affinity-is-broken-in-ia32-with-MSI-enabled.patch"
In-Reply-To: <20060128021749.GA10362@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Shaohua Li <shaohua.li@intel.com>

Setting irq affinity stops working when MSI is enabled.  With MSI, move_irq
is empty, so we can't change irq affinity.  It appears a typo in Ashok's
original commit for this issue.  X86_64 actually is using move_native_irq.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/io_apic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.6.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.14.6/arch/i386/kernel/io_apic.c
@@ -1937,7 +1937,7 @@ static void ack_edge_ioapic_vector(unsig
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	ack_edge_ioapic_irq(irq);
 }
 
@@ -1952,7 +1952,7 @@ static void end_level_ioapic_vector (uns
 {
 	int irq = vector_to_irq(vector);
 
-	move_irq(vector);
+	move_native_irq(vector);
 	end_level_ioapic_irq(irq);
 }
 

--
