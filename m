Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVCSDle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVCSDle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 22:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVCSDld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 22:41:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:38333 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261884AbVCSDlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 22:41:31 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: Fix agp_backend usage in drm_agp_init (was: 2.6.11-mm3 - DRM/i915 broken)
Date: Fri, 18 Mar 2005 19:40:53 -0800
User-Agent: KMail/1.7.2
Cc: Dave Airlie <airlied@gmail.com>, Mike Werner <werner@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, m4rkusxxl@web.de
References: <20050312034222.12a264c4.akpm@osdl.org> <21d7e99705031601363f27296@mail.gmail.com> <423B9261.9040108@ens-lyon.org>
In-Reply-To: <423B9261.9040108@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503181940.54252.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 18, 2005 6:45 pm, Brice Goglin wrote:
> agpioc_acquire_wrap is called, it increments the agp_in_use. Then (before
> agpioc_release_wrap happens), drm_agp_init is called (I don't know how).
> drm_agp_init uses agp_backend_acquire which fails because agp_in_use is
> non-null (hold by agpioc_acquire_wrap).
>
> The multi-bridge AGP patch actually changed drm_agp_init by adding
> agp_backend_acquire/release around agp_copy_info.
> It is why drm_agp_init fails now while it worked before.
>
> I don't think we need to "acquire" it during agp_copy_info.
> Why don't we just get a pointer to the bridge instead ?
> (is there any chance this bridge gets deleted during drm_agp_init ?)
> That's what the attached patch implements on top of 2.6.12-rc1.
>
> I chose to add a new agp_backend_find() function, but we might also
> directly call agp_find_bridge() from drm_agp_init(). I don't know what's
> the best.
>
> I'm not familiar enough with DRM/AGP code to understand everything here.
> I might be missing something...

What does your patch look like?  Markus might like to try it out as he 
narrowed his problem down to something AGP related recently too:
http://bugme.osdl.org/show_bug.cgi?id=4337

Thanks,
Jesse
