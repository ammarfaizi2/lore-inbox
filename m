Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUHaJMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUHaJMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUHaJMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:12:03 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25757 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267612AbUHaJJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:09:17 -0400
Date: Tue, 31 Aug 2004 18:10:40 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [PATCH 4/4][diskdump] x86-64 support
In-reply-to: <20040828112324.B8000@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <9AC48F3A62CFC4indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.63
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040828112324.B8000@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comment.

On Sat, 28 Aug 2004 11:23:24 +0100, Christoph Hellwig wrote:

>> +mptscsih_sanity_check(struct scsi_device *sdev)
>> +{
>> +	MPT_ADAPTER    *ioc;
>> +	MPT_SCSI_HOST  *hd;
>> +
>> +	hd = (MPT_SCSI_HOST *) sdev->host->hostdata;
>> +	if (!hd)
>> +		return -ENXIO;
>> +	ioc = hd->ioc;
>> +
>> +	/* message frame freeQ is busy */
>> +	if (spin_is_locked(&ioc->FreeQlock))
>> +		return -EBUSY;
>
>As in the scsi code spin_is_locked checks are bogus and racy.  Only
>a spin_trylock would be safe.  hd can't be NULL.

Could you explain to me why spin_is_locked is not safe?

Regards,
Takao Indoh
