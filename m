Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269263AbRHGS3u>; Tue, 7 Aug 2001 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269281AbRHGS3k>; Tue, 7 Aug 2001 14:29:40 -0400
Received: from [209.234.73.40] ([209.234.73.40]:2565 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S269263AbRHGS3Y>;
	Tue, 7 Aug 2001 14:29:24 -0400
Date: Tue, 7 Aug 2001 13:28:26 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS file corruption
Message-ID: <20010807132826.T17468@altus.drgw.net>
In-Reply-To: <3B6E84A1.1A13969@crm.mot.com> <3B6E8A09.ABCDAFFC@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B6E8A09.ABCDAFFC@redhat.com>; from arjanv@redhat.com on Mon, Aug 06, 2001 at 01:14:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 01:14:02PM +0100, Arjan van de Ven wrote:
> Emmanuel Varagnat wrote:
> > 
> > Today, I crashed the kernel and after reboot the source file
> > I was working on, was completly unreadable. The size indicated
> > by 'ls' seems to be good but with bad data.
> 
> Well reiserfs doesn't guarantee the CONTENTS of the file to be 
> consistent after a crash; only the metadata.

Hrrrm, maybe the following change (or something like it) would be good 
for Documentation/Configure.help

===== Configure.help 1.46 vs edited =====
--- 1.46/Documentation/Configure.help   Sat Aug  4 11:40:39 2001
+++ edited/Configure.help       Tue Aug  7 13:27:41 2001
@@ -11706,7 +11706,12 @@
 CONFIG_REISERFS_FS
 
   Stores not just filenames but the files themselves in a balanced
-  tree.  Uses journaling.
+  tree.  Currently uses metatdata-only journaling.
+
+  (NOTE: metadata-only journalling only ensures the filesystem is
+  consistent after a crash, NOT the data! You need data AND metadata
+  journaling to guarantee open files do not get corrupted on a crash.
+  full data journalling is also slower.)
 
   Balanced trees are more efficient than traditional
   filesystem architectural foundations.

