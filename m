Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbVHINYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVHINYj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVHINYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:24:39 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:20352 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932537AbVHINYi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:24:38 -0400
Message-ID: <42F8AE91.9030708@ext.bull.net>
Date: Tue, 09 Aug 2005 15:24:33 +0200
From: Frederic TEMPORELLI <frederic.temporelli@ext.bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: max workqueue name length
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/08/2005 15:36:56,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/08/2005 15:36:58,
	Serialize complete at 09/08/2005 15:36:58
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


When creating a workqueue, workqueue name is limited to 10 chars
(kernel/workqueue.c , function is __create_workqueue, test is done in a BUG_ON).

Why has this length be limited to 10 chars ?
Can I safely increase this max length (13 chars should be enough...) ?



Some comments about these questions:

In SCSI layer, HBA kernel ID is incremented after each modprobe/rmmod.

Then, when a scsi driver is managing a working queue and HBA kernel ID is 
greater than 99 (let's assume that you have modprobe/rmmod the scsi driver to 
get this ID to 99, or you may have play with 'scsi_debug' module), an oops is 
generated when loading again the driver (and the driver is frozen).

This is because working queue name format is "scsi_wq_%d" (drivers/scsi/hosts.c 
, function scsi_add_host, %d is the HBA ID), and so working queue name length is 
greater than 10 chars when HBA kernel ID is > 99...


Best regards


-- 
Frederic TEMPORELLI
