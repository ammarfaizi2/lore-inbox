Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWFXThI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFXThI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWFXThI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:37:08 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:55472 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1751060AbWFXThG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:37:06 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=Wjk9N9YqOev84lAzTCYXdE5yJLNDU64YABOF7jEuHHNtNjUt+zR9zrGoIr3efPiMxCZaIOyGShP7rMFfo4V6H3jal2/pQu2Cjg9Di0ZGTho9cmIglc5RrRlMQ3d2PKvu;
X-IronPort-AV: i="4.06,172,1149483600"; 
   d="scan'208"; a="35571031:sNHT34179327"
Date: Sat, 24 Jun 2006 14:37:05 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Corey Minyard <minyard@acm.org>
Cc: Peter Palfrader <peter@palfrader.org>,
       openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] BUG: soft lockup detected on CPU#1, ipmi_si
Message-ID: <20060624193704.GB14713@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060613233521.GO22999@asteria.noreply.org> <44962116.70302@acm.org> <20060619093851.GL27377@asteria.noreply.org> <449AA320.3060700@acm.org> <20060623025649.GE15027@lists.us.dell.com> <449C7CF0.4000002@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449C7CF0.4000002@acm.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 06:44:48PM -0500, Corey Minyard wrote:
> I also had a report from Matt that running the driver full-bore caused
> the mouse to go haywire.  I did some testing and the mouse didn't go
> haywire, but my keyboard did.  I changed the udelay(1) to schedule() and
> kipmi0 is running at 100% as I type right now, and things seem to be
> running smoothly.  Testing the performance, I got 4.5ms per message for
> a get device id, which was the same as I saw before the change.  So I
> think this change is a good idea.

I tried this here too, and while I'm not at the console to try the
mouse, the times for 'ipmitool sensor list' are still within the same
range (5-10 seconds, average is about 6) as with udelay(1) instead.
Running some load generators to keep the CPUs pegged didn't change
this result either.  So I'm inclined to agree changing to schedule()
is the right approach.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
