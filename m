Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTBFQsb>; Thu, 6 Feb 2003 11:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTBFQsb>; Thu, 6 Feb 2003 11:48:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11278 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267356AbTBFQsa>; Thu, 6 Feb 2003 11:48:30 -0500
Date: Thu, 6 Feb 2003 17:58:06 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] quota memleak (fwd)
Message-ID: <20030206165806.GD28223@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Linus,

  please apply the following bugfix (fixes memleak on error condition).

						Thanks
							Honza

----- Forwarded message from "Randy.Dunlap" <randy.dunlap@verizon.net> -----

Date: Wed, 05 Feb 2003 12:14:56 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: jack@suse.cz
Subject: [PATCH] quota memleak
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.54 i686)

Hi,

The Stanford Checker found a memleak.
Please consider applying.  For 2.5.59.

Thanks,
~Randy

----------------------------------------------------------------------
diff -Naur ./fs/quota_v2.c%LEAK ./fs/quota_v2.c
--- ./fs/quota_v2.c%LEAK	Thu Jan 16 18:22:29 2003
+++ ./fs/quota_v2.c	Tue Feb  4 21:37:07 2003
@@ -306,6 +306,7 @@
 		blk = get_free_dqblk(filp, info);
 		if ((int)blk < 0) {
 			*err = blk;
+			freedqbuf(buf);
 			return 0;
 		}
 		memset(buf, 0, V2_DQBLKSIZE);

