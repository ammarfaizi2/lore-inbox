Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWB1RCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWB1RCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWB1RCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:02:54 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:50205 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751883AbWB1RCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:02:53 -0500
X-IronPort-AV: i="4.02,153,1139212800"; 
   d="scan'208"; a="1780511234:sNHT33151104"
To: Jes Sorensen <jes@sgi.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
X-Message-Flag: Warning: May contain useful information
References: <1140841250.2587.33.camel@localhost.localdomain>
	<yq08xrvhkee.fsf@jaguar.mkp.net> <adar75nlcar.fsf@cisco.com>
	<44047565.3090202@sgi.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 28 Feb 2006 09:02:47 -0800
In-Reply-To: <44047565.3090202@sgi.com> (Jes Sorensen's message of "Tue, 28
 Feb 2006 17:08:05 +0100")
Message-ID: <adafym3l8lk.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Feb 2006 17:02:48.0509 (UTC) FILETIME=[CD5A16D0:01C63C88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jes> Not quite correct as far as I understand it. mmiowb() is
    Jes> supposed to guarantee that writes to MMIO space have
    Jes> completed before continuing.  That of course covers the
    Jes> multi-CPU case, but it should also cover the write-combining
    Jes> case.

I don't believe this is correct.  mmiowb() does not guarantee that
writes have completed -- they may still be pending in a buffer in a
bridge somewhere.  The _only_ effect of mmiowb() is to make sure that
writes which have been ordered between CPUs using some other mechanism
(i.e. a lock) are properly ordered by the rest of the system.  This
only has an effect systems like very large ia64 systems, where (as I
understand it), writes can pass each other on the way to the PCI bus.
In fact, mmiowb() is a NOP on essentially every architecture.

 - R.
