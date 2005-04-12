Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVDLICf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVDLICf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVDLICc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:02:32 -0400
Received: from mail.hometree.net ([194.77.152.181]:30104 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S262041AbVDLICY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:02:24 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: [2.6.11.7] switch fallthrough in scsi_ioctl.c ?
Date: Tue, 12 Apr 2005 08:02:22 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <d3fvae$b33$1@tangens.hometree.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1113292942 11363 194.77.152.164 (12 Apr 2005 08:02:22 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 12 Apr 2005 08:02:22 +0000 (UTC)
X-Copyright: (C) 1996-2005 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed that in scsi_ioctl.c (Kernel 2.6.11.7), there are fallthroughs
in the sshdr.sense_key switch (Line 124 and beyond):

[...]
		case NOT_READY:	/* This happens if there is no disc in drive */
			if (sdev->removable && (cmd[0] != TEST_UNIT_READY)) {
				printk(KERN_INFO "Device not ready. Make sure"
				       " there is a disc in the drive.\n");
				break;
			}

***** ---> Fallthrough there is device is not removeable or command is not TEST_UNIT_READY

		case UNIT_ATTENTION:
			if (sdev->removable) {
				sdev->changed = 1;
				sreq->sr_result = 0;	/* This is no longer considered an error */
				break;
			}

***** ---> Fallthrough there is device is not removeable

		default:	/* Fall through for non-removable media */
[...]

I was wondering if this is intentional and if yes, this should be
clearly marked as such (The usual /* FALLTHROUGH */). If this is
intentional, then the logic in this statement is seriously in need of
documentation... :-)

	Regards
		Henning




-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

RedHat Certified Engineer -- Jakarta Turbine Development  -- hero for hire
   Linux, Java, perl, Solaris -- Consulting, Training, Development

"Now you can start with implementation and integration and do the
requirements later".  -- Prof. Dr. Dr. h.c. Manfred Broy about the new
german federal software development standard "V-Model XT" 
(found at http://de.biz.yahoo.com/050207/299/4en0t.html)
