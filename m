Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVCXIpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVCXIpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCXIpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:45:05 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:9376 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262723AbVCXIpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:45:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MvBD1dB/Qvw+XLhnOT/tcCKTyJ5Be62JcXRx7yHo8GWAJwUsPS3moAF6C6mbW8sqBmcosXB71K6dMybR4qdi1GBYkiI9kbATV72Fd6R+CIZBFlJ9dOrZVCW/yzXsMUmQcfyWRZY2AvIlirJVZ3pdsk/ytDSOSGZQi0+w2QUbjIU=
Message-ID: <21d7e99705032400455da41016@mail.gmail.com>
Date: Thu, 24 Mar 2005 19:45:00 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: werner@sgi.com
Subject: Re: Fix agp_backend usage in drm_agp_init (was: 2.6.11-mm3 - DRM/i915 broken)
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970503231247179b7c46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <21d7e99705031601363f27296@mail.gmail.com>
	 <423B9261.9040108@ens-lyon.org> <200503191247.48963.werner@sgi.com>
	 <21d7e9970503231247179b7c46@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I assume this bug is going to occur on i8x0 chipsets where the X
> server may acquire the agp to do 2D stuff and the drm then acquires it
> later for 3D stuff this may be a bit broken but it is out there now
> ...

I've confirmed this is the problem, the intel drivers need AGP for 2D
code paths, the DRM then acquires the bridge for 3D code paths... 
this is standard and we can't change it now as it would mean changing
existing userspaces.. I'm not sure how to tackle it.. Brice's patch
may work in all cases but I want to check it on a few configurations
..

Dave, now running (FC3+Xorg CVS and Debian Sarge and switching between
i865/radeon/mga cards trying to track these bugs down...)
