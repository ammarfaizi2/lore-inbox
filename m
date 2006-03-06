Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752450AbWCFWcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbWCFWcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbWCFWcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:32:31 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:14619 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1752034AbWCFWca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:32:30 -0500
X-IronPort-AV: i="4.02,169,1139212800"; 
   d="scan'208"; a="259922004:sNHT31991784"
To: "David S. Miller" <davem@davemloft.net>
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <adaoe0j5kd6.fsf@cisco.com> <440CACB5.2010609@ichips.intel.com>
	<adabqwj5j7b.fsf@cisco.com>
	<20060306.142814.109285730.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 14:32:28 -0800
In-Reply-To: <20060306.142814.109285730.davem@davemloft.net> (David S. Miller's message of "Mon, 06 Mar 2006 14:28:14 -0800 (PST)")
Message-ID: <aday7zn432b.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 22:32:28.0651 (UTC) FILETIME=[D9B6BBB0:01C6416D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Please make sure you check "x86_64 vs. x86", and then
    David> something like "powerpc64 vs. powerpc32" or "sparc64
    David> vs. sparc32", as those are the two different classes of ABI
    David> layouts.

Yes, I tried ppc64 vs ppc and it still comes out the same.
Unfortunately I don't have any sparc handy to try.

The fundamental question seems to be whether things like

	struct foo {
		struct sockaddr_in6 src;
		struct sockaddr_in6 dst;
	};

and

	struct bar {
		struct sockaddr_in6 a;
		__u32 b;
	};

end up being packed, even though struct sockaddr_in6 is 28 bytes in
size.  And as far as I can tell, they always do, I guess because the
individual fields of struct sockaddr_in6 are all <= 32 bits.

 - R.
