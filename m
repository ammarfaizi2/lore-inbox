Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVAHSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVAHSas (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVAHSas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 13:30:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32163 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261246AbVAHSam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 13:30:42 -0500
Message-ID: <41E00E81.92B2E0D1@sgi.com>
Date: Sat, 08 Jan 2005 08:46:57 -0800
From: Mike Werner <werner@sgi.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; IRIX64 6.5-ALPHA-1289606320 IP35)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Benoit Boissinot <bboissin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
References: <20050106002240.00ac4611.akpm@osdl.org>
		 <40f323d005010701395a2f8d00@mail.gmail.com>
		 <21d7e99705010718435695f837@mail.gmail.com>
		 <40f323d00501080427f881c68@mail.gmail.com> <21d7e99705010805424ec16550@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> 
> > > >
> > > > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > > >
> > > > [drm:drm_unlock] *ERROR* Process 10657 using kernel context 0
> > > >
> > >
> > > this looks like the agp backend isn't loading, Mike sent me parts of
> > > your .config but I lost the mail (don't drink and read e-mail...)
> > >
> >
> 
> it looks like agp_backend_acquire is returning NULL in this case,
> [drm:drm_ioctl] pid=10587, cmd=0x6430, nr=0x30, dev 0xe200, auth=1
> [drm:drm_ioctl] ret = ffffffed
> is the agp acquire ioctl and the return is -ENODEV
> 
> Any ideas Mike why that might happen?
> 
> Dave.

If the bridge->agp_in_use is non-zero then drm_agp_acquire would return
-ENODEV.
Previously it would return -EBUSY in this case but agp_backend_acquire
now returns
a pointer to a bridge so there is no distinction made between existence
and busy.
