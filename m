Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTD3Qbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbTD3Qbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:31:55 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:56531 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261240AbTD3Qby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:31:54 -0400
Date: Wed, 30 Apr 2003 18:41:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Some handy scripts if you are using quilt for kernel
Message-ID: <20030430164153.GA7467@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...unfortunately it depends on on-disk layout, so it is really rather
specialized. First allows to patch to the next Linus kernel with all
patches applied:

quilt-update-kernel:
#
# Run from .pc directory
for A in *; do ( cd $A; find . | ( while true; do read B || exit; cp /usr/src/clean/$B $B; done ); ); done


Second one shows you "what have you done since last quilt refresh". It
takes time.

quilt-diff:
#!/bin/bash
rm -rf /usr/src/tmp/linux
cp -al /usr/src/clean.2.5 /usr/src/tmp/linux
cat /usr/src/linux/patches/series | while true; do
    read PATCHNAME || exit
    echo Processing $PATCHNAME
    cd /usr/src/tmp/linux
    cat /usr/src/linux/patches/$PATCHNAME | patch -Efsp1
done
echo Diffing tree
diff-tree /usr/src/tmp/linux /usr/src/linux | tee /tmp/delme.quilt-diff

Oh and then my diff-tree script:

diff-tree:
#!/bin/bash
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x 'System.map' -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' -x '*.cmd' $*

I hope its usefull for someone.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
