Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWEXUt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWEXUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWEXUt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:49:56 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:29407 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S932344AbWEXUtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:49:55 -0400
Message-ID: <4474C6F2.1010304@candelatech.com>
Date: Wed, 24 May 2006 13:49:54 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Issue with make -j4 when building in separate tree.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a dependency problem when running
make with multiple jobs (-j4).

I am compiling 2.6.16.16 in a separate tree.  I created
the tree with the command:

[greear@xeon-dt linux-2.6.dev]$ make O=~/kernel/2.6/linux-2.6.16.k6/ xconfig

Then tried to build with this command.

[greear@xeon-dt linux-2.6.16.k6]$ make -j4 bzImage modules
make -C /home/greear/git/linux-2.6.dev O=/home/greear/kernel/2.6/linux-2.6.16.k6 bzImage
make -C /home/greear/git/linux-2.6.dev O=/home/greear/kernel/2.6/linux-2.6.16.k6 modules
   GEN    /home/greear/kernel/2.6/linux-2.6.16.k6/Makefile
   GEN    /home/greear/kernel/2.6/linux-2.6.16.k6/Makefile
   CHK     include/linux/version.h
   CHK     include/linux/version.h
   UPD     include/linux/version.h
   UPD     include/linux/version.h
mv: cannot stat `include/linux/version.h.tmp': No such file or directory
make[2]: *** [include/linux/version.h] Error 1
make[1]: *** [bzImage] Error 2
make: *** [bzImage] Error 2
make: *** Waiting for unfinished jobs....
   SYMLINK include/asm -> include/asm-i386


This error has existed at least since 2.6.13.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

