Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTKYWuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 17:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTKYWuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 17:50:07 -0500
Received: from main.gmane.org ([80.91.224.249]:47754 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263292AbTKYWuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 17:50:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: thomas weidner <3.14159@gmx.net>
Subject: do_kern_mount return value question
Date: Tue, 25 Nov 2003 23:36:16 +0100
Message-ID: <pan.2003.11.25.22.36.10.741477@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this post is no bug or patch, but a simple question about the kernel
source. Why does do_kern_mount return ENODEV when the given filesystem is
unknown? EINVAL seems to be better to me. when i change from ENODEV to
EINVAL (fs/super.c:713 in 2.6.0-test10) the following szenario works as i
except:
kernel options: rootfstype=ext3,ext2
1. load ext2 initrd
2. try to mount as ext3 -> fails (ext3 is a module in my configuration and
not in the kernel)
3. try to mount it as ext2 -> fine
4. handle initrd
5. try to mount root as ext3 -> fine (ext3 module now loaded)

the vanilla kernel stops after 2. because some late boot code thinks the
initrd is an invalid device (ENODEV).

