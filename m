Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTECQWo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263347AbTECQWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:22:44 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:40210 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263340AbTECQWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:22:43 -0400
Date: Sat, 3 May 2003 17:35:09 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: FBDEV patch for testing.
Message-ID: <Pine.LNX.4.44.0305031726360.4509-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  I needed this patch to be tested. The patch has two parts. The first is 
updates to the g346fb driver to use the cursor api. The second part is 
a code optimization of the pixmap code. The purpose of the pixmap code is
to take image data and byte or word padd it according to the needs of the 
hardware. The problem was it was only copy on byte at a time. This was a 
performace killer. Soon now it copies a whole scanline at a time. Please 
test.

The diff is at 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

 drivers/video/console/fbcon.c |  219 +++++++++++++++---------------------------
 drivers/video/fbmem.c         |    5 
 drivers/video/g364fb.c        |   78 ++++++++------
 drivers/video/logo/logo.c     |    3 
 include/linux/fb.h            |   63 ++++++------
 include/linux/linux_logo.h    |    4 
 6 files changed, 163 insertions(+), 209 deletions(-)


