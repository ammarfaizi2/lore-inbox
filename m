Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWBFXdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWBFXdu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWBFXdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:33:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24234 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964867AbWBFXdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:33:50 -0500
Date: Tue, 7 Feb 2006 10:30:46 +1100
From: Nathan Scott <nathans@sgi.com>
To: Luca <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] Linux 2.6.16-rcX breaks mutt
Message-ID: <20060206233046.GC791@frodo>
References: <20060206172141.GA15133@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206172141.GA15133@dreamland.darkstar.lan>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Mon, Feb 06, 2006 at 06:21:41PM +0100, Luca wrote:
> Hi,
> I found out that mutt when running with a 2.6.16-rcX kernel is unable to
> discover new mails in mboxes other than the main one.
> ...
> I've done a simple test with working and non working system:

I constructed a test case based on your description, and this patch
fixes it for me - could you try it out & let me know how it goes in
yoour case?

thanks.

-- 
Nathan

--- fs/xfs/linux-2.6/xfs_iops.c.orig	2006-02-07 10:49:34.143620000 +1100
+++ fs/xfs/linux-2.6/xfs_iops.c	2006-02-07 10:49:57.785097500 +1100
@@ -673,6 +673,8 @@ linvfs_setattr(
 	if (ia_valid & ATTR_ATIME) {
 		vattr.va_mask |= XFS_AT_ATIME;
 		vattr.va_atime = attr->ia_atime;
+		if (ia_valid & ATTR_ATIME_SET)
+			inode->i_atime = attr->ia_atime;
 	}
 	if (ia_valid & ATTR_MTIME) {
 		vattr.va_mask |= XFS_AT_MTIME;
