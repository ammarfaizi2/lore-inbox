Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUKFKPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUKFKPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKFKPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:15:38 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2228 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S261351AbUKFKPd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:15:33 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: linux-kernel@vger.kernel.org
Subject: BUG at fs/inode.c:1100 in usermode linux 2.6.9 with hostfs as root.
Date: Sat, 6 Nov 2004 04:17:04 -0600
User-Agent: KMail/1.5.4
Cc: jdike@karaya.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411060417.04191.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting hostfs as the root filesystem doesn't seem to work.  I compiled 
usermode linux (tar xvjf linux-2.6.9.tar.bz2; cd linux-2.6.9; make ARCH=um 
menuconfig; make ARCH=um).  Compiled in hostfs (I can send my config if it 
helps but I tried disabling just about everything while debugging and the 
problem didn't change.)

I ran the result with the following command line:

./vmlinux init=/bin/sh rootflags=/path/to/rootdir,rw rootfstype=hostfs

And it gave the error message in the title.

Before this, I tried following what Documention/uml says about using hostfs as 
a root device, but it doesn't work.  It's talking about ubd, not hostfs.  
(I've tried with ubd compiled in and without it compiled in, no difference.)  
It says unknown root device 98:0 and please use a root=option and never tries 
to mount a hostfs anything.

The above command line does make it mount hostfs.  I can stick in a printf and 
a sys_access() right after prepare_namespace() in init/main.c, and it can see 
the files in the directory.  But if I let the boot continue, it hits the 
BUG()...

Er... Help?

Rob

