Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWCPExz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWCPExz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWCPExz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:53:55 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:54613 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932366AbWCPExy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:53:54 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Mar 2006 20:53:50 -0800
In-Reply-To: <1142477579.6994.124.camel@localhost.localdomain> (Bryan O'Sullivan's message of "Wed, 15 Mar 2006 18:52:59 -0800")
Message-ID: <adad5gnt2g1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Mar 2006 04:53:52.0660 (UTC) FILETIME=[9F5D2540:01C648B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Bad page state at free_hot_cold_page (in process 'mpi_hello', page ffff810002098af8)
 > flags:0x0100000000000404 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)

You're setting PG_reserved somewhere.  That's deprecated now.  Just do
get_page() unconditionally and be happy.  I don't think there's any
way that your pages could be swapped out, even though you don't do
SetPageReserved().

 - R.
