Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWFWC4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWFWC4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWFWC4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:56:47 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:34645 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751070AbWFWC4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:56:46 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=BiAYEnYkv1qGyVRzwq4pjxcehPKAv7cSkkZUSLpl9FY1BsuTjPBZ2QB1AqzB15lUza+xMp9E88lABELHTvNIoxYgoCaCJGCcZsKJiHJbm2fZCjR8xbOoH86oQidePaii;
X-IronPort-AV: i="4.06,167,1149483600"; 
   d="scan'208"; a="34981840:sNHT28010358"
Date: Thu, 22 Jun 2006 21:56:49 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Corey Minyard <minyard@acm.org>
Cc: Peter Palfrader <peter@palfrader.org>, linux-kernel@vger.kernel.org,
       openipmi-developer@lists.sourceforge.net
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
Message-ID: <20060623025649.GE15027@lists.us.dell.com>
References: <20060613233521.GO22999@asteria.noreply.org> <44962116.70302@acm.org> <20060619093851.GL27377@asteria.noreply.org> <449AA320.3060700@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449AA320.3060700@acm.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:03:12AM -0500, Corey Minyard wrote:
> Peter, can you make a code change for me and try something out?
> 
> If possible, could you change the call to udelay(1) in the function
> ipmi_thread() in drivers/char/ipmi_si_intf.c to be a call to schedule()
> instead?  I'm guessing that will fix this problem.

won't that cause the thread to be scheduled out for at least one timer
tick (1-10ms depending on HZ), especially as it's at nice 19?  This
will cause the commands to be quite slow, which was the primary reason
for the kthread here in the first place.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
