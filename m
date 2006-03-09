Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWCIXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWCIXLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWCIXLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:11:13 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:51846 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751394AbWCIXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:11:12 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="414152053:sNHT30524180"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 7 of 20] ipath - misc driver support code
X-Message-Flag: Warning: May contain useful information
References: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:11:09 -0800
In-Reply-To: <2f16f504dd4b98c2ce7c.1141922820@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:00 -0800")
Message-ID: <aday7zjfc36.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:11:11.0197 (UTC) FILETIME=[C14C60D0:01C643CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static unsigned handle_frequent_errors(struct ipath_devdata *dd,
 > +				       ipath_err_t errs, char msg[512],
 > +				       int *noprint)
 > +{
 > +	cycles_t nc;
 > +	static cycles_t nextmsg_time;
 > +	static unsigned nmsgs, supp_msgs;
 > +
 > +	/*
 > +	 * throttle back "fast" messages to no more than 10 per 5 seconds
 > +	 * (1.4-2GHz clock).  This isn't perfect, but it's a reasonable
 > +	 * heuristic. If we get more than 10, give a 5x longer delay
 > +	 */

Could this be replaced by printk_ratelimit()?

 - R.
