Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUHPNjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUHPNjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHPNjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:39:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:13783 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267634AbUHPNhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:37:31 -0400
Date: Mon, 16 Aug 2004 15:37:30 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: /bin/ls: cannot read symbolic link /proc/$$/exe: Permission denied
Message-ID: <20040816133730.GA6463@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For some reasons ls -l /proc/$$/exe doesnt work all time for me,
with 2.6.8.1 on ppc64. Sometimes it does, sometimes not. No pattern.
A few printks show that this check in proc_pid_readlink() triggers
an -EACCES:

        current->fsuid != inode->i_uid

proc_pid_readlink(755) error -13 ntptrace(11408) fsuid 100 i_uid 0 0
sys_readlink(281) ntptrace(11408) error -13 readlink
proc_pid_readlink(755) error -13 ls(11509) fsuid 91 i_uid 0 0
sys_readlink(281) ls(11509) error -13 readlink
proc_pid_readlink(755) error -13 ls(11559) fsuid 91 i_uid 0 0
sys_readlink(281) ls(11559) error -13 readlink
proc_pid_readlink(755) error -13 ls(11621) fsuid 91 i_uid 0 0
sys_readlink(281) ls(11621) error -13 readlink

any ideas what is supposed to happen here? Who should set the
inode->i_uid? ssh to the smp box runs the login scripts, they try to
figure out what shell is running via ls -l /proc/$$/exe
This works ok with our 2.6.5 kernel at least.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
