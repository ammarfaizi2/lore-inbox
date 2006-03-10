Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752128AbWCJApV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbWCJApV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWCJApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:45:21 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:23976 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1752128AbWCJApR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:45:17 -0500
X-IronPort-AV: i="4.02,180,1139212800"; 
   d="scan'208"; a="414188887:sNHT33599040"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
X-Message-Flag: Warning: May contain useful information
References: <28bb276205de498d0b5c.1141950939@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 16:45:15 -0800
In-Reply-To: <28bb276205de498d0b5c.1141950939@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 16:35:39 -0800")
Message-ID: <adaslprcelg.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 00:45:16.0713 (UTC) FILETIME=[E649C190:01C643DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, now I can see the change you made:

 > +atomic_t ipath_sma_alive;
 > +DEFINE_SPINLOCK(ipath_sma_lock);	/* SMA receive */

So why is ipath_sma_alive an atomic_t (and why isn't it static)?
You never modify ipath_sma_alive outside of your spinlock, so I don't
see what having it be atomic buys you.

 - R.
