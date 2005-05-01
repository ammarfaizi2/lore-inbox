Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVEBTOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVEBTOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVEBTOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:14:20 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:63900 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261715AbVEBTOQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:14:16 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: plougher@users.sourceforge.net, LKML <linux-kernel@vger.kernel.org>
Subject: SquashFS cleanup: container_of over list_entry
Date: Sun, 1 May 2005 19:04:59 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505011905.00434.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at fs/squashfs/inode.c (in the release used on Gentoo) I've found this 
code:

static inline struct squashfs_inode_info *SQUASHFS_I(struct inode *inode)
{
        return list_entry(inode, struct squashfs_inode_info, vfs_inode);
}

>From the cosmetical point of view, shouldn't that be:
        return container_of(inode, struct squashfs_inode_info, vfs_inode);
? The implementation is the same, but the second is clearer (adding a 
definition in the header would be OK if you need that it works on 2.4, if 
that's the reason).

My 2 cents.

Regards.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


