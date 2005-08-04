Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVHDSbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVHDSbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 14:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbVHDSbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 14:31:31 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:9324 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261203AbVHDSba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 14:31:30 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Move InfiniBand .h files
X-Message-Flag: Warning: May contain useful information
References: <52iryla9r5.fsf@cisco.com>
	<1123178038.3318.40.camel@laptopd505.fenrus.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 04 Aug 2005 11:31:24 -0700
In-Reply-To: <1123178038.3318.40.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Thu, 04 Aug 2005 19:53:58 +0200")
Message-ID: <52acjxa70j.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Aug 2005 18:31:25.0649 (UTC) FILETIME=[B8B14410:01C59922]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> At minimum the headers should be split in separate files
    Arjan> for shared-userspace and kernel (eg no overlap at all), but
    Arjan> I'd vote for keeping the headers in your own dir.

This is already done -- the userspace ABI is defined in ib_user_mad.h,
ib_user_verbs.h, etc.

The problem with keeping subsystem headers under drivers/infiniband is
that it's ugly for, say, fs/nfs/Makefile to have to add
-Idrivers/infiniband/include to its CFLAGS just because it's
implementing NFS/RDMA.

Also, drivers/infiniband/include doesn't get put into the
/lib/modules/<ver>/build directory, so it's a pain for people
developing new drivers (this is a real complaint that came to me from
a vendor developing a driver for a new piece of IB hardware).

Thanks,
  Roland
