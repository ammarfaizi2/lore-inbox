Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUFBRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUFBRsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:48:22 -0400
Received: from [194.85.238.98] ([194.85.238.98]:23250 "EHLO school.ioffe.ru")
	by vger.kernel.org with ESMTP id S263752AbUFBRsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:48:17 -0400
Date: Wed, 2 Jun 2004 21:48:10 +0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
Message-ID: <20040602174810.GA31263@school.ioffe.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried enabling SELinux on my Linux-box, using ReiserFS as /, kernel
2.6.7-rc2.

After relabeling and rebooting in non-enforcing mode everything worked
well, exept the fact, that new files on reiserfs filesystems don't get
security attributes.

So I added 'fs_use_xattr reiserfs system_u:object_r:fs_t;' to the policy,
rebooted and found, that mount hangs during opening of /etc/mtab~<pid>
(even in non-enforcing mode).

If I remove that line from SELinux policy, systems boots up OK.

Here are last lines from #strace mount / -o remount :

=== Cut ===
open("/etc/mtab~202", O_WRONLY|O_CREAT|O_LARGEFILE, 0600audit(1085949484.378:0): avc:  denied  { write } for  pid=202 exe=/bin/mount name=etc dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=dir
audit(1085949484.378:0): avc:  denied  { add_name } for  pid=202 exe=/bin/mount name=etc dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=dir
audit(1085949484.378:0): avc:  denied  { create } for  pid=202 exe=/bin/mount name=mtab~202 dev=hda5 ino=91 scontext=system_u:system_r:kernel_t tcontext=system_u:object_r:etc_t tclass=file
=== Cut ===

Tell me, if I need to provide any additional info.

-- 
With best wishes
Dmitry Baryshkov
