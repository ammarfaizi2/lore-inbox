Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVAMDlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVAMDlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVAMDlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:41:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:22425 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261396AbVAMDlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:41:17 -0500
Subject: Re: [PATCH] ppc64: xtime <-> gettimeofday can get out of sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050110132429.GS14239@krispykreme.ozlabs.ibm.com>
References: <20050110132429.GS14239@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 14:40:55 +1100
Message-Id: <1105587656.27435.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note that the time_sync_xtime check only stops the seconds from going
> backwards, the ns component still could couldnt it? Considering this
> is hard to get right, should we switch to the time interpolator stuff?
> The only problem there is it might be trouble for systemcfg (which
> exports stuff to do userspace gettimeofday).

My userland implementation in the vDSO also relies on our current
algorithm. It's not merged yet and could be changed of course, but I
ended up quite liking our current code ;) 

The interesting thing with it is we are basically lock-less
(and even barrier-less on reads).

Ben.


