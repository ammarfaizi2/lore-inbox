Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWB1Rvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWB1Rvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWB1Rvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:51:46 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:31754 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932286AbWB1Rvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:51:45 -0500
X-IronPort-AV: i="4.02,153,1139212800"; 
   d="scan'208"; a="410865090:sNHT10528260350"
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
X-Message-Flag: Warning: May contain useful information
References: <1140841250.2587.33.camel@localhost.localdomain>
	<200602251428.01767.ak@suse.de>
	<1140894083.9852.30.camel@localhost.localdomain>
	<200602280944.32210.jbarnes@virtuousgeek.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 28 Feb 2006 09:50:48 -0800
In-Reply-To: <200602280944.32210.jbarnes@virtuousgeek.org> (Jesse Barnes's
 message of "Tue, 28 Feb 2006 09:44:31 -0800")
Message-ID: <ada7j7fl6dj.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Feb 2006 17:50:48.0852 (UTC) FILETIME=[822B8D40:01C63C8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jesse> I don't think it addresses the flushing issue you seem to
    Jesse> be concerned about though.  I don't know the exact
    Jesse> semantics of sfence, but I think bcrl is likely right that
    Jesse> it won't absolutely guarantee that your writes have hit the
    Jesse> device before proceeding (though it may do that on some CPU
    Jesse> implementations).

Yeah, I think that Bryan just wrote something different than what he
meant: there is no desire for wc_wmb() to make sure that writes via a
write-combining mapping have gone all the way to the device, any more
than a normal wmb() makes sure normal writes have gone all the way to
the device.  All that wc_wmb() needs to do is make sure that writes
via a write-combining mapping don't get passed by later writes.

This does speak to the need for precise documentation though :)

 - R.
