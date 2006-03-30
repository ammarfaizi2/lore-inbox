Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWC3U7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWC3U7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWC3U7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:59:20 -0500
Received: from test-iport-3.cisco.com ([171.71.176.78]:22554 "EHLO
	test-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750911AbWC3U7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:59:19 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 0 of 16] ipath - driver submission for 2.6.17
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143674603@chalcedony.internal.keyresearch.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 30 Mar 2006 12:59:17 -0800
In-Reply-To: <patchbomb.1143674603@chalcedony.internal.keyresearch.com> (Bryan O'Sullivan's message of "Wed, 29 Mar 2006 15:23:23 -0800")
Message-ID: <adairpv1wey.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Mar 2006 20:59:18.0863 (UTC) FILETIME=[CFDAC5F0:01C6543C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there are still problems with dependencies on networking.
If I start with allnoconfig and just enable CONFIG_PCI,
CONFIG_PCI_MSI, CONFIG_INFINIBAND, CONFIG_IPATH_CORE and
CONFIG_INFINIBAND_IPATH, the build ends with:

      LD      .tmp_vmlinux1
    drivers/built-in.o: In function `ipath_free_pddata': undefined reference to `kfree_skb'
    drivers/built-in.o: In function `ipath_alloc_skb': undefined reference to `__alloc_skb'
    drivers/built-in.o: In function `ipath_kreceive': undefined reference to `skb_over_panic'
    drivers/built-in.o: In function `ipath_init_chip': undefined reference to `kfree_skb'

Should I just make IPATH_CORE depend on NET as well?

 - R.
