Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbUJWOdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUJWOdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUJWOdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:33:20 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:47883 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261198AbUJWOdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:33:17 -0400
Date: Sat, 23 Oct 2004 15:33:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Message-ID: <20041023143309.GA32417@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@gmail.com>, Jon Smirl <jonsmirl@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e473391041022214570eab48a@mail.gmail.com> <20041023095644.GC30137@infradead.org> <21d7e99704102307287a08247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e99704102307287a08247@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 12:28:18AM +1000, Dave Airlie wrote:
> > 
> > Sorry, wrong API.  At least export the individual functions and use them
> > directly (and without the symbol_get abnomination that's not any better
> > than inter_module_*).
> 
> I wonder what the reasoning behind the old drm_agp structure was in
> the first place?
> 
> What about this patch?

The patch looks good to me, I really like the reduced complexity.

Some minor nitpicks below:

+	if (!(head = DRM(alloc)(sizeof(*head), DRM_MEM_AGPLISTS)))
+		return NULL;
+	memset((void *)head, 0, sizeof(*head));

no need to cast to void * here

@@ -428,41 +409,37 @@
  */
 void DRM(agp_uninit)(void)
 {
-	DRM_AGP_PUT;
-	drm_agp = NULL;
 }

is the function needed by BSD?  Else it should probably go away completely.

