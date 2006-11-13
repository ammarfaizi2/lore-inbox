Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754331AbWKMJhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbWKMJhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbWKMJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:37:15 -0500
Received: from ns2.suse.de ([195.135.220.15]:63361 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753768AbWKMJhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:37:13 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: kenneth.w.chen@intel.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com>
	<20061108.230059.57444310.davem@davemloft.net>
	<20061109072216.GL29920@ftp.linux.org.uk>
	<20061108.235548.12921799.davem@davemloft.net>
	<20061113085223.GR29920@ftp.linux.org.uk>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2006 10:37:03 +0100
In-Reply-To: <20061113085223.GR29920@ftp.linux.org.uk>
Message-ID: <p73y7qf3cxs.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:
> 
> Incidentally, WTF is
> define SK_CS_CALCULATE_CHECKSUM
> #ifndef CONFIG_X86_64
> #define SkCsCalculateChecksum(p,l)      ((~ip_compute_csum(p, l)) & 0xffff)
> #else
> #define SkCsCalculateChecksum(p,l)      ((~ip_fast_csum(p, l)) & 0xffff)   
> #endif
> in ./drivers/net/sk98lin/h/skdrv1st.h?

Looks totally bogus. The x86-64 ip_fast_csum is practically identical
to the i386 version. Someone must have been asleep while reviewing
that code.

But AFAIK sk98lin is scheduled for deletion anyways, to be replaced by 
sky*. Probably for good reasons. Hopefully soon.

-Andi
