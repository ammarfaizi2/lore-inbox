Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUEDXUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUEDXUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 19:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUEDXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 19:20:34 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:41168 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S261351AbUEDXUc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 19:20:32 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: 2.6.2 scsi host reset success but all device are offlined
Date: Tue, 4 May 2004 17:20:31 -0600
Message-ID: <0A78D025ACD7C24F84BD52449D8505A15A8131@wcosmb01.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.2 scsi host reset success but all device are offlined
Thread-Index: AcQyLmSJWjt/ofOLTE6SQB6snUHMHQ==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Cc: <yiding_wang@agilent.com>
X-OriginalArrivalTime: 04 May 2004 23:20:32.0033 (UTC) FILETIME=[6529A910:01C4322E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.2 linux on i386. During the error injection test, eh_device_reset, eh_bus_reset and eh_host_reset were called by scsi_error.c in sequence.  For each reset, HBA driver returned SUCCESS (0x2002, I specially traced the host reset case). 

The quesion is why scsi_error.c failed to react properly according to the returned reset status.

The scsi_eh_host_reset() calls scsi_try_host_reset() and further calls hba eh_host_reset_handler. Upon the retuned status SUCCESS (0x2002), it shoud not call function scsi_eh_offline_sdevs().  Inmy case, every time host reset SUCCESS will lead to "Device offlined" situation from scsi_eh_offline_sdevs(). All available device are lost.

I thought I might get quick answer for this issue from commmunity before debugging into scsi layer code.

Thanks!

Eddie
