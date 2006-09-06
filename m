Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWIFPzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWIFPzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 11:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWIFPzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 11:55:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56208 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751154AbWIFPzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 11:55:08 -0400
Date: Wed, 6 Sep 2006 12:02:10 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Anholt <eric@anholt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resubmit: Intel 965 Express AGP patches
Message-ID: <20060906160210.GK15918@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org
References: <115747785570-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115747785570-git-send-email-eric@anholt.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 10:37:32AM -0700, Eric Anholt wrote:
 > The following should be the updated patch series for the Intel 965 Express
 > support, unless I'm making some mistake with git-send-email.  I think I've
 > covered Dave's concerns 

This chunk seems unrelated to 965 support.

@@ -1469,7 +1570,7 @@ static struct agp_bridge_driver intel_91
        .owner                  = THIS_MODULE,
        .aperture_sizes         = intel_i830_sizes,
        .size_type              = FIXED_APER_SIZE,
-       .num_aperture_sizes     = 3,
+       .num_aperture_sizes     = 4,
        .needs_scratch_page     = TRUE,
        .configure              = intel_i915_configure,
        .fetch_size             = intel_i915_fetch_size,

It seems to be a valid fix (as there are indeed 4 entries in
intel_i830_sizes), but I wonder if this was intentional ?
Has this been tested on 915/945?
I've chopped this bit out and committed the rest, we can
add this as a separate commit, which may ease future bisecting
if anything should go awry.
The intel_830_driver struct also lists the num of sizes as '3' btw.
It could just be lots of cut-n-paste braindamage, but things like
this make me nervous in a driver that supports so much hardware
and is so.. twisted.

Also, do we need an entry in agp_intel_resume() for the 965 ?

 >, except for making the PCI ID stuff table-driven.
 > You can find a patch for that on the intel-agp-i965 branch at
 > git://anongit.freedesktop.org/~anholt/linux-2.6

I'll take a look at those soon.

	Dave

