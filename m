Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVHHWN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVHHWN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVHHWNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:13:25 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:3687 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S932348AbVHHWNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:13:24 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Question about multiple modules talking to one adapter
X-Message-Flag: Warning: May contain useful information
References: <42F7C853.90901@ammasso.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 08 Aug 2005 15:13:10 -0700
In-Reply-To: <42F7C853.90901@ammasso.com> (Timur Tabi's message of "Mon, 08
 Aug 2005 16:02:11 -0500")
Message-ID: <521x54yt55.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Aug 2005 22:13:10.0946 (UTC) FILETIME=[5CEB7820:01C59C66]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timur> 1) Each driver registers its own ISR and has its own
    Timur> mapping the adapter memory.

This is silly and leads to all sorts of horrible code.  For example
you'll have to deal with the fact that only one driver can do
request_mem_region() on the PCI adapter, and no matter what you come
up with, it's going to be ugly.

    Timur> 2) Create a single driver which does nothing but register
    Timur> an ISR and map the kernel memory.  Let's call this the CRM
    Timur> driver.  The other three drivers can then use XXXXXX to
    Timur> provide callbacks for the ISR and obtain the address of the
    Timur> mapping.  The ISR will then query the adapter and call the
    Timur> appropriate callback.

This is the best solution.  I don't see any disadvantage to this.

 - R.
