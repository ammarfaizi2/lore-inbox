Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWCWTT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWCWTT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCWTT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:19:58 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:13693 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751431AbWCWTT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:19:57 -0500
X-IronPort-AV: i="4.03,123,1141632000"; 
   d="scan'208"; a="263759145:sNHT31300284"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       greg@kroah.com, openib-general@openib.org
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <patchbomb.1143072293@eng-12.pathscale.com>
	<dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	<20060323064113.GC9841@mellanox.co.il>
	<1143103701.6411.21.camel@camp4.serpentine.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 23 Mar 2006 11:18:53 -0800
In-Reply-To: <1143103701.6411.21.camel@camp4.serpentine.com> (Bryan O'Sullivan's message of "Thu, 23 Mar 2006 00:48:21 -0800")
Message-ID: <adaacbhvujm.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Mar 2006 19:18:53.0908 (UTC) FILETIME=[9FCF5940:01C64EAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> We have customers who use our driver who do not want a full
    Bryan> IB stack present, for example in embedded environments.

I think it's fine that your low-level driver can work without ib_core,
ib_mad and the rest loaded.  But I still (after all this discussion)
don't understand why you need to have two SMA implementations to
handle this along with the code to switch between the two modes like:

 > +	list_for_each_entry(dd, &ipath_dev_list, ipath_list) {
 > +		if (!(dd->ipath_flags & IPATH_INITTED))
 > +			continue;
 > +		*dd->ipath_statusp &= ~IPATH_STATUS_SMA;
 > +		if (ipath_verbs_registered)
 > +			*dd->ipath_statusp |= IPATH_STATUS_OIB_SMA;
 > +	}

You also have all the functions like recv_subn_get_nodeinfo() etc. for
handling SM queries.  Presumably all this is duplicated in the
userspace SMA.  Why can't you get down to one NodeInfo query handler?

 - R.
