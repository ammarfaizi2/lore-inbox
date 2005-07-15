Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVGOIm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVGOIm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbVGOIm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 04:42:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64014 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261870AbVGOImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 04:42:24 -0400
Date: Fri, 15 Jul 2005 09:41:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715094157.C25428@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
	Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
	dtor_core@ameritech.net, vojtech@suse.cz,
	david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
	azarah@nosferatu.za.org, christoph@lameter.com
References: <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <9a874849050714171767b85ced@mail.gmail.com> <Pine.LNX.4.58.0507141735390.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507141735390.19183@g5.osdl.org>; from torvalds@osdl.org on Thu, Jul 14, 2005 at 05:42:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 05:42:15PM -0700, Linus Torvalds wrote:
> So this is why I so strongly argue that we should have a constant HZ, but 
> a dynamic _increment_ of "jiffies". Nobody (obviously) depends on jiffies 
> being constant, so it's ok to increment jiffies by pretty much any value.

I agree.  Isn't this exactly what HZ=1000 with VST achieves?  We
know this works already...

> But I really wouldn't be surprised if the bogomips calibration loop was 
> really the only thing that needed some small tweaking for increments of 
> other than one.

Having run VST on ARM, VST must be disabled while the bogomips
calibrations have completed - I suspect VST requires some sort of
enable/disable counted system like we do for interrupts and the hlt
thing, so that the hotplug CPU code can do it's bogomips calibration
appropriately.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
