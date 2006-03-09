Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWCIXWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWCIXWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCIXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:22:25 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:13351 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932109AbWCIXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:22:24 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="414157169:sNHT31069992"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 2 of 20] ipath - core device driver
X-Message-Flag: Warning: May contain useful information
References: <75d0a170fc9b4f016f8b.1141922815@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:22:22 -0800
In-Reply-To: <75d0a170fc9b4f016f8b.1141922815@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:46:55 -0800")
Message-ID: <adahd67fbkh.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:22:22.0681 (UTC) FILETIME=[5188B490:01C643D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +	if (dd->ipath_unit >= atomic_read(&ipath_max))
 > +		atomic_set(&ipath_max, dd->ipath_unit + 1);

If this is the way you use ipath_max, why is it an atomic variable?  I
can't find any uses of ipath_max that don't look racy if the only
thing protecting it is the fact that it's an atomic_t, and if it has
some other protection, then I don't think it needs to be atomic.

 - R.
