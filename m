Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbTL2EzI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 23:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTL2EzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 23:55:08 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:5513 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262686AbTL2EzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 23:55:04 -0500
Date: Mon, 29 Dec 2003 04:55:01 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: chmod of active swap file blocks
Message-ID: <Pine.LNX.4.56.0312290434360.2270@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to chmod a file being used for swap causes chmod() to block,
with permissions change /not/ having taken effect, until the swap
file is swapoff'd, at which point chmod() carries on and chmod (the
command) finishes.

# swapon /.swapfile 
# cat /proc/swaps 
Filename				Type		Size	Used	Priority
/dev/ide/host0/bus0/target0/lun0/part1   partition	200772	51748	-1
/.swapfile                               file		131064	0	-5
# strace chmod g-w /.swapfile 2> /tmp/strace-chmod &
[3] 29208
# tail /tmp/strace-chmod 
[ snip ]
stat64("/.swapfile", {st_mode=S_IFREG|0600, st_size=134217728, ...}) = 0
chmod("/.swapfile", 0600
# swapoff /.swapfile 
# 
[3]   Done                    strace chmod g-w /.swapfile 2>/tmp/strace-chmod

NB: no, i dont use devfs :) (just same namespace.)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Save energy:  Drive a smaller shell.
