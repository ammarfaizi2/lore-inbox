Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbUKFNqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUKFNqC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 08:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUKFNqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 08:46:02 -0500
Received: from main.gmane.org ([80.91.229.2]:52124 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261392AbUKFNp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 08:45:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Missing SCSI command in the allowed list?
Date: Sat, 06 Nov 2004 18:47:12 +0500
Message-ID: <cmikie$vif$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While cloning an audio CD using cdrdao 1.1.9 with vanilla linux-2.6.9 as a
user, I see the following "errors":

ERROR: Read buffer capacity failed.

This refers to the buffer in the CD drive. The indiation of the drive buffer
fill is missing. The clone sounds like the original. The command used for
cloning:

cdrdao copy --device /dev/hdd --source-device /dev/hdb \
--drivergeneric-mmc-raw --speed 8 --on-the-fly --paranoia-mode 1 -v 1 \
--fast-toc

If I run that as root, there are no such "errors", and levels of both the
software cdrdao buffer and hardware buffer in the drive are indicated.

Looks like the following SCSI command is missing from the allowed list:

cmd[0] = 0x5c; // READ BUFFER CAPACITY

(according to cdrdao source, Sony CDU920 uses 0xec instead, but I don't have
Sony drives here). Please fix the list or explain why this cannot be done.

-- 
Alexander E. Patrakov

