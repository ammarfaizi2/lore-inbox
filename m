Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTKMVzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264435AbTKMVzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:55:18 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:9595 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264433AbTKMVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:55:09 -0500
Date: Thu, 13 Nov 2003 14:55:06 -0700
From: "Erik A. Hendriks" <hendriks@lanl.gov>
To: linux-kernel@vger.kernel.org
Subject: ptrace + ioctl( LOOP_SET_FD ) brokeness.
Message-ID: <20031113215506.GO23534@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following hangs reliably on 2.4.22 (test on x86 and x86_64):

strace mount -o loop somefile /mnt

the mount program ends up wedged in the D state.  The last file lines
of the strace look like this:

open("/dev/loop0", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, 0x4c03, 0xbfffded0)            = -1 ENXIO (No such device or address)
close(3)                                = 0
open("xxx", O_RDWR|O_LARGEFILE)         = 3
open("/dev/loop0", O_RDWR|O_LARGEFILE)  = 4
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
ioctl(4, 0x4c00


- Erik
