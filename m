Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWB1Pm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWB1Pm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWB1Pm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 10:42:57 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:50085 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751255AbWB1Pm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 10:42:56 -0500
X-IronPort-AV: i="4.02,153,1139212800"; 
   d="scan'208"; a="258423117:sNHT32103872"
To: Jes Sorensen <jes@sgi.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
X-Message-Flag: Warning: May contain useful information
References: <1140841250.2587.33.camel@localhost.localdomain>
	<yq08xrvhkee.fsf@jaguar.mkp.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 28 Feb 2006 07:42:52 -0800
In-Reply-To: <yq08xrvhkee.fsf@jaguar.mkp.net> (Jes Sorensen's message of "28
 Feb 2006 05:01:29 -0500")
Message-ID: <adar75nlcar.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Feb 2006 15:42:52.0729 (UTC) FILETIME=[A2D82290:01C63C7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jes> Could you explain why the current mmiowb() API won't suffice
    Jes> for this?  It seems that this is basically trying to achieve
    Jes> the same thing.

I don't believe mmiowb() is at all the same thing.  mmiowb() is all
about ordering writes between _different_ CPUs without incurring the
cost of flushing posted writes by issuing a read on the bus.  wc_wmb()
would just act like a true wmb(), even when using write-combining
regions on x86 -- in other words, there would be no cross-CPU synchronization.

 - R.
