Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUEMNSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUEMNSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUEMNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:18:30 -0400
Received: from j110113.ppp.asahi-net.or.jp ([61.213.110.113]:16396 "EHLO
	mail.tar.bz") by vger.kernel.org with ESMTP id S264176AbUEMNSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:18:22 -0400
Message-ID: <40A37598.1020901@ThinRope.net>
Date: Thu, 13 May 2004 22:18:16 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Too restrictive permissions on some files prevent non-root build
 (with KBUILD_OUTPUT) [bug 2669]
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I still cannot understand which is better to post bugs here or on the bugzilla, so I'll try both this time.

http://bugzilla.kernel.org/show_bug.cgi?id=2669

The problem is that several files were not world readable and this prevents non-root builds by using the new KBUILD_OUTPUT variable.

For 2.6.6 the files in question can be found by:
cd /sometempdir
tar xjf linux-2.6.6.tar.bz2
find linux-2.6.6 ! -perm -004 -exec ls -l {} \;

I guess the one that most people need is the linux-2.6.6/drivers/char/agp/isoch.c

To fix your tree you can (safely?) use:
find /usr/src/linux-2.6.6 ! -perm -004 -exec chmod o+r {} \;

No idea how exactly the tarball is build, but there can be a check proces like the above before making it final.

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
