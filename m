Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbWARUH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbWARUH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWARUH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:07:29 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:3624 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1030406AbWARUH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:07:27 -0500
X-IronPort-AV: i="3.99,381,1131350400"; 
   d="scan'208"; a="393304004:sNHT32510288"
To: Jes Sorensen <jes@sgi.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Why is wmb() a no-op on x86_64?
X-Message-Flag: Warning: May contain useful information
References: <1137601417.4757.38.camel@serpentine.pathscale.com>
	<200601181729.36423.ak@suse.de>
	<1137603169.4757.50.camel@serpentine.pathscale.com>
	<yq04q41qxcw.fsf@jaguar.mkp.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 18 Jan 2006 12:07:23 -0800
In-Reply-To: <yq04q41qxcw.fsf@jaguar.mkp.net> (Jes Sorensen's message of "18
 Jan 2006 12:06:39 -0500")
Message-ID: <ada4q41wb9g.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Jan 2006 20:07:25.0508 (UTC) FILETIME=[CCD24040:01C61C6A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> On x86_64, we fiddle with the MTRRs to enable write
    Bryan> combining, which makes a huge difference to performance.
    Bryan> It's not clear to me what we should even do on other
    Bryan> architectures, since the only generic entry point that even
    Bryan> exposes write combining is pci_mmap_page_range, which is
    Bryan> for PCI mmap through userspace, and half the arches I've
    Bryan> looked at ignore its write_combine parameter.

    Jes> A job for mmiowb() perhaps?

I don't think the semantics of mmiowb() do what is desired here.
mmiowb() is all about ordering writes between separate CPUs, and the
issue at hand here is that write-combining buffers might reorder
writes from a single CPU.

 - R.
