Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVLPBFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVLPBFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVLPBFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:05:05 -0500
Received: from fmr24.intel.com ([143.183.121.16]:11682 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751246AbVLPBFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:05:04 -0500
Date: Thu, 15 Dec 2005 17:04:40 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: hawkes@sgi.com
Cc: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Message-ID: <20051216010440.GA9886@agluck-lia64.sc.intel.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com> <20051215225040.GA9086@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215225040.GA9086@agluck-lia64.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:50:40PM -0800, Luck, Tony wrote:
> This does make the function a bit big for an "inline" though.  Does
> it really need to be inline?  Do we care how fast our delay loops
> are?

Moving the current slim-line udelay() out of line would save 41 Kbytes
of text in the generic vmlinux, plus making any modules that use
udelay smaller too. Savings run from a 128-160 bytes for drivers
with just one call to a max of 9 Kbytes for qla2xxx.ko.

Being out-of-line would reduce accuracy, but this would only be
significant when the sleep is for a very small number of microseconds.

So if we need to add more code to udelay(), I think that it
should be moved out-of-line too (into arch/ia64/kernel/time.c).

alpha, m68knommu, powerpc and sh64 already have out of line udelay().

-Tony
