Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUKQWMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUKQWMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKQWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:09:13 -0500
Received: from ozlabs.org ([203.10.76.45]:17047 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262606AbUKQWHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:07:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.52144.648958.233683@cargo.ozlabs.ibm.com>
Date: Thu, 18 Nov 2004 09:07:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kai Makisara <Kai.Makisara@metla.fi>, Willem Riede <osst@riede.org>,
       coda@cs.cmu.edu
Subject: Re: [patch 0/4] Cleanup file_count usage
In-Reply-To: <20041117165021.GC3152@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
	<16794.32730.184008.344036@cargo.ozlabs.ibm.com>
	<20041117165021.GC3152@impedimenta.in.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai writes:

> How about this patch?  This doesn't leak memory hopefully. 
> 
> --- 
> Patch to cleanup reads to f_count from ppp driver, deprecate PPPIOCDETACH 
> ioctl, and print warning messages if the ioctl is used.  
> 
> A new 'detached' field is included in struct ppp_file, and the ppp
> channel/interface is marked as detached when PPPIOCDETACH is invoked
> instead of checking the f_count and failing the ioctl for 'if the fd was
> dup'd' case. The ppp structure is freed on last close.

The difficulty comes when pppd does a PPPIOCNEWUNIT, a PPPIOCDETACH,
and another PPPIOCNEWUNIT.  To test that, you would need to use
ppp-2.4.0 or ppp-2.4.1 and use the persist option to pppd.  Make one
connection and then terminate it (unplug the modem, or use the idle
option to pppd).  Pppd should then try to reestablish the connection.
The question is whether the second connection attempt succeeds or not.
I think that with your patch it won't (from a quick look).

Paul.
