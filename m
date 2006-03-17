Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752480AbWCQBMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbWCQBMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbWCQBMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:12:35 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:63265 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1752485AbWCQBMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:12:32 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="1785708087:sNHT3324945208"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace
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
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	<adad5gmne20.fsf_-_@cisco.com>
	<1142553361.15045.19.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 17:12:17 -0800
In-Reply-To: <1142553361.15045.19.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 16 Mar 2006 15:56:01 -0800")
Message-ID: <adapsklnaby.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Mar 2006 01:12:17.0312 (UTC) FILETIME=[D521CA00:01C6495F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Why would you not want accesses to explode?  Exploding
    Bryan> seems like the right behaviour to me, since there's no
    Bryan> hardware for userspace to talk to any more.

Oh yeah... but getting rid of the mapping so userspace gets a segfault
might be a good idea too.  However, leaving the old PCI mapping there
seems rather risky to me: I think it's entirely possible that accesses
to that area after the device is gone could trigger machine checks or
worse.

So what's the right way for a driver to get rid of a remap_pfn_range()
mapping into userspace?

 - R.
