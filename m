Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUBZLJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUBZLJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:09:21 -0500
Received: from mail-gate.ait.ac.th ([202.183.214.47]:7397 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP id S262770AbUBZLJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:09:19 -0500
Date: Thu, 26 Feb 2004 18:09:03 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: linux-kernel@vger.kernel.org
Subject: smbfs broken in 2.4.25? (Too many open files in system)
Message-ID: <20040226110903.GC621@ait.ac.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hope I won't get flamed for this, I've spent a  fair  amount  of  time
searching archives and news without finding anything close enough.

Since I've updated my Slackware 8.0 desktop to the 2.4.25 kernel (from
source, loaded .config from .24)  I  can't  access  shares  off  Win9x
systems reliably (98/98SE tested). smbfs is loaded as a module.

I get random 'Too many open files in system'. E.g.:

# /usr/local/samba/bin/smbmount //w98box/c /dosc -o password=xxxxx
# ls /dosc
/bin/ls: /dosc: Too many open files in system
(command repeated several times: hit up arrow and enter... and then:)
# ls /dosc
ASD.LOG*       BIN/          CONFIG.TXT*  MSDOS.SYS*       SUHDLOG.---*
AUTOEXEC.001*  BOOTLOG.DMA*  CONFIG.W95*  MSDOS.W95*       SUHDLOG.BAK*
(...works!)

It seems to randomly succeed or fail, with a majority of failures.
I've been able to catch messages like the following in syslog:

Feb 26 13:42:27 alain kernel: smb_lookup: find windows/MSDFMAP.INI failed, error=-23

This used to work flawlessly in 2.4.24.
The Gods of Linux forgive me, I've copied ./fs/smbfs/* and
./include/linux/smb*.h from the 2.4.24 tree, "make modules" and
reloaded smbfs.o: now it works all the time!

Some background: Samba is v2.2.8a built from source.

Any hints? I've tried rebuilding smbfs with debug options in the
Makefile, SMBFS_PARANOIA on and off, I haven't been able to
make much sense out of it. It keeps failing in every configuration.

Greets,
_Alain_
