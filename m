Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTEZOFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTEZOFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:05:33 -0400
Received: from pop3.galileo.co.il ([199.203.130.130]:37621 "EHLO
	galileo5.galileo.co.il") by vger.kernel.org with ESMTP
	id S264385AbTEZOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:05:32 -0400
Message-ID: <3ED22FBC.50405@il.marvell.com>
Date: Mon, 26 May 2003 18:16:12 +0300
From: Rabeeh Khoury <rabeeh@il.marvell.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Re: [RFR] a new SCSI driver
References: <20030524195123.GA8394@gtf.org>
In-Reply-To: <20030524195123.GA8394@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small correction to the code -
While translating the GET_CAPACITY to ATA, you are returning the number of sectors the ATA drive but the GET_CAPACITY requests the last addressable sector.
So you should return (n_sectors-1).


static void ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *reqbuf,
			        unsigned int buflen)
{
	u64 n_sectors = args->dev->n_sectors;
	u32 tmp;
+++ n_sectors --;
	VPRINTK("ENTER\n");



