Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279584AbRJXUK6>; Wed, 24 Oct 2001 16:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279583AbRJXUKj>; Wed, 24 Oct 2001 16:10:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20352 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278632AbRJXUKc>;
	Wed, 24 Oct 2001 16:10:32 -0400
Date: Wed, 24 Oct 2001 13:10:14 -0700 (PDT)
Message-Id: <20011024.131014.59653371.davem@redhat.com>
To: baggins@sith.mimuw.edu.pl
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: [PATCH] Acenic fix (was Re: acenic breakage in 2.4.13-pre)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011024180414.A16921@sith.mimuw.edu.pl>
In-Reply-To: <20011024.082925.68578636.davem@redhat.com>
	<20011024180414.A16921@sith.mimuw.edu.pl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
   Date: Wed, 24 Oct 2001 18:04:14 +0200

   On Wed, 24 Oct 2001, David S. Miller wrote:
   
   >    From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
   >    Date: Wed, 24 Oct 2001 16:45:33 +0200
   >    
   >    Speaking of acenic - it's broken in 2.4.13-pre. I have 3c985 and all I
   >    get with 2.4.13-pre is "Firmware NOT running!". After I backed the
   >    changes from -pre patch it started and works fine. Maybe the problem is
   >    I have it in 32bit PCI slot?
   > 
   > Do you have CONFIG_HIGHMEM enabled?  If so, please try with
   > it turned off.
   
   Nope. No HIGHMEM here.

The patch below should cure the problem.

Linus, please apply.

diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore vanilla/linux/drivers/net/acenic.c linux/drivers/net/acenic.c
--- vanilla/linux/drivers/net/acenic.c	Fri Oct 12 15:35:53 2001
+++ linux/drivers/net/acenic.c	Wed Oct 24 08:32:43 2001
@@ -1051,7 +1051,8 @@
 	struct ace_private *ap;
 	struct ace_regs *regs;
 	struct ace_info *info = NULL;
-	unsigned long tmp_ptr, myjif;
+	u64 tmp_ptr;
+	unsigned long myjif;
 	u32 tig_ver, mac1, mac2, tmp, pci_state;
 	int board_idx, ecode = 0;
 	short i;
