Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbVHTUgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVHTUgA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 16:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVHTUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 16:36:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751052AbVHTUf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 16:35:59 -0400
Date: Sat, 20 Aug 2005 16:35:38 -0400
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@g5.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       g@parcelfarce.linux.theplanet.co.uk
Subject: Re: Fix up befs compile.
Message-ID: <20050820203538.GA19728@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linus Torvalds <torvalds@g5.osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	g@parcelfarce.linux.theplanet.co.uk
References: <20050820194840.GA8455@redhat.com> <20050820195807.GD29811@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050820195807.GD29811@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 08:58:07PM +0100, Al Viro wrote:
 > On Sat, Aug 20, 2005 at 03:48:40PM -0400, Dave Jones wrote:
 > > fs/befs/linuxvfs.c:466: error: conflicting types for 'befs_follow_link'
 > > fs/befs/linuxvfs.c:44: error: previous declaration of 'befs_follow_link' was here
 > > fs/befs/linuxvfs.c: In function 'befs_follow_link':
 > > fs/befs/linuxvfs.c:490: warning: return makes integer from pointer without a cast
 > 
 > It should be void *, not void.

Duh. Yes. of course.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/fs/befs/linuxvfs.c~	2005-08-20 15:46:30.000000000 -0400
+++ linux-2.6.12/fs/befs/linuxvfs.c	2005-08-20 15:47:25.000000000 -0400
@@ -461,7 +461,7 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int
+static void *
 befs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);

		Dave

