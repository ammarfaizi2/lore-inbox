Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTDMWRi (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTDMWRi (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:17:38 -0400
Received: from holomorphy.com ([66.224.33.161]:6016 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262598AbTDMWRh (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 18:17:37 -0400
Date: Sun, 13 Apr 2003 15:29:08 -0700
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Subject: dentry leak in 2.5.x
Message-ID: <20030413222908.GA8956@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seen on 2.5.65-mm3, updatedb got dentry + inode caches eating 740/768MB:

$ head /proc/sys/fs/*state
==> /proc/sys/fs/dentry-state <==
1192481 1194571 45      0       0       0
==> /proc/sys/fs/inode-state <==
1182447 49053   0       0       0       0       0

Then, after listening to it swap for a while (the screen stopped
unblanking) I saw the state of affairs unchanged by swapoff -a:

$ head /proc/sys/fs/*state
==> /proc/sys/fs/dentry-state <==
1192501 1194592 45      0       0       0
==> /proc/sys/fs/inode-state <==
1182451 49053   0       0       0       0       0

Followed by blind reboot via sysrq, nothing visible on VGA or remotely.
I suspect a leak (or something). nr_unused is greater than nr_dentry.
UP 600MHz K7 768MB RAM, Adaptec 39160, tulip + eepro, reiserfs, preempt.


-- wli
