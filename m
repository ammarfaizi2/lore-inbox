Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268496AbUJUQTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268496AbUJUQTC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUJUQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:16:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:390 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S268720AbUJUQMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:12:17 -0400
Date: Thu, 21 Oct 2004 18:12:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Quota warnings somewhat broken
Message-ID: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


When a user exceeds his soft (and hard) disk quota, a warning message is
printed to current->tty. However, output is a bit offset:

$ dd if=/dev/zero of=blk bs=1024 count=100000
hda1: write failed, user block limit reached.
                                             dd: opening `blk': Disk quota exceeded

This is due to the messages in fs/dquot.c only ending in "\n" but should
probably end in "\r\n".
A patch can be found @
http://linux01.org:2222/f/hxtools/kernel/265-quota_warnfix.diff (only use the
dquot.c chunk). Despite it saying 2.6.4, it's still in 2.6.9.

Any takers?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
Tel 0162.3520895 or 05502.3009.63
