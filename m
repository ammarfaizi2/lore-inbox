Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTDWUUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbTDWUUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:20:18 -0400
Received: from bloodbath.burble.org ([198.144.201.93]:52493 "EHLO
	bloodbath.burble.org") by vger.kernel.org with ESMTP
	id S263529AbTDWUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:20:16 -0400
From: pixi@burble.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Stephane Ouellette <ouellettes@videotron.ca>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH]  Undefined symbol sync_dquots_dev() in quota.c
References: <3EA6B13A.4000408@videotron.ca> <20030423153341.GA5561@gtf.org>
	<3EA6B854.5010604@videotron.ca> <20030423160244.GB5561@gtf.org>
Date: 23 Apr 2003 13:32:06 -0700
In-Reply-To: <20030423160244.GB5561@gtf.org>
Message-ID: <m21xzt7y61.fsf@bloodbath.burble.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Jeff Garzik <jgarzik@pobox.com> writes:

: On Wed, Apr 23, 2003 at 11:59:16AM -0400, Stephane Ouellette wrote:

: >   the file fs/dquot.c is compiled only if CONFIG_QUOTA is set.  That 
: > would imply modifying the Makefile and #ifdeffing most of the code 
: > inside dquot.c.
: 
: So?  ;-)
: 
: Your patch modified fs/quota.c, which is compiled when CONFIG_QUOTACTL is
: set, which in turn is set for CONFIG_QUOTA || CONFIG_XFS_QUOTA.
: 
: If you are adding CONFIG_QUOTA ifdefs to fs/quota.c, it is clear a
: non-ifdef solution can be achieved.

yep.  attached is the patch i made when i compiled the kernel, but
forgot to send on:


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=quotaops.h.diff

--- include/linux/quotaops.h.orig	2003-04-15 20:31:50.000000000 -0700
+++ include/linux/quotaops.h	2003-04-15 20:31:59.000000000 -0700
@@ -185,6 +185,7 @@
  */
 #define sb_dquot_ops				(NULL)
 #define sb_quotactl_ops				(NULL)
+#define sync_dquots_dev(dev,type)		(NULL)
 #define DQUOT_INIT(inode)			do { } while(0)
 #define DQUOT_DROP(inode)			do { } while(0)
 #define DQUOT_ALLOC_INODE(inode)		(0)

--=-=-=--
