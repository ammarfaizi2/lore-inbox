Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWIFRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWIFRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWIFRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:15:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751750AbWIFRPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:15:54 -0400
Date: Wed, 6 Sep 2006 13:22:57 -0400
From: Dave Jones <davej@redhat.com>
To: Eric Anholt <eric@anholt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Resubmit: Intel 965 Express AGP patches
Message-ID: <20060906172257.GB20304@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org
References: <115747785570-git-send-email-eric@anholt.net> <20060906160210.GK15918@redhat.com> <1157561785.11752.12.camel@vonnegut>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157561785.11752.12.camel@vonnegut>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 09:56:25AM -0700, Eric Anholt wrote:
 > > Also, do we need an entry in agp_intel_resume() for the 965 ?
 > Yeah, looks like it.

Ok, I added this ..


diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 42c7d8d..d1ede7d 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -1924,6 +1924,8 @@ static int agp_intel_resume(struct pci_d
                intel_i830_configure();
        else if (bridge->driver == &intel_810_driver)
                intel_i810_configure();
+       else if (bridge->driver == &intel_i965_driver)
+               intel_i915_configure();
 
        return 0;
 }


This bit could probably be cleaned up a lot by having a .suspend method
in the bridge struct too, but thats for another day.

	Dave
