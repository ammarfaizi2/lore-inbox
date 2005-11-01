Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbVKAEzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVKAEzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVKAEza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:55:30 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:37270 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965018AbVKAEz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:55:29 -0500
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH/RFC] IB: Add SCSI RDMA Protocol (SRP) initiator
X-Message-Flag: Warning: May contain useful information
References: <52wtjtk3d1.fsf@cisco.com>
	<20051101110409V.fujita.tomonori@lab.ntt.co.jp>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 20:55:23 -0800
In-Reply-To: <20051101110409V.fujita.tomonori@lab.ntt.co.jp> (FUJITA
 Tomonori's message of "Tue, 01 Nov 2005 11:04:09 +0900")
Message-ID: <52irvdge6c.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 01 Nov 2005 04:55:24.0536 (UTC) FILETIME=[785C0F80:01C5DEA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    FUJITA> Any reason the existing SRP definitions
    FUJITA> (drivers/scsi/ibmvscsi/srp.h) doesn't work for you?

Wow ... I never realized that ibmvscsi was an SRP initiator as well.

Anyway, looking at drivers/scsi/ibmvscsi/srp.h, the main problem I see
is that the file has a bunch of bitfields that are big-endian only
(which makes sense because the driver can only be compiled for pSeries
or iSeries anyway).

But I have no objection to moving the file to include/scsi/srp.h,
adding a bunch of

    #if defined(__LITTLE_ENDIAN_BITFIELD)
    #elif defined(__BIG_ENDIAN_BITFIELD)
    #endif

and adding a few missing defines, and then converting ib_srp to use
the same file.

Does that seem like the right thing to do?

Thanks,
  Roland
