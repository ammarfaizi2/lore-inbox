Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRC2R4E>; Thu, 29 Mar 2001 12:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRC2Rzz>; Thu, 29 Mar 2001 12:55:55 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:6930 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S132797AbRC2Rzs>; Thu, 29 Mar 2001 12:55:48 -0500
Date: Thu, 29 Mar 2001 12:55:51 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] Support for "mode" parameter in ramfs
Message-ID: <Pine.LNX.4.33.0103291234360.800-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch adds support for the "mode" parameter in ramfs. This parameter
only affects one inode - the top-level directory (since you can specify
mode in open() and mkdir() for everything else) and thus eliminates the
race condition between "mount" and "chmod" by eliminating the need to use
"chmod".

Like other filesystems, the "mode" is parsed as an octal number.

It is now possible to put the following line in /etc/fstab:

none      /tmp         ramfs     mode=1777     0 0

but please make sure that untrusted users cannot kill your system by
creating huge files in /tmp!

The patch is also available online at
http://www.red-bean.com/~proski/linux/root_mode.diff

Regards,
Pavel Roskin

