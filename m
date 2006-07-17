Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWGQV3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWGQV3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGQV3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:29:53 -0400
Received: from deine-taler.de ([217.160.107.63]:46785 "EHLO
	p15091797.pureserver.info") by vger.kernel.org with ESMTP
	id S1751194AbWGQV3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:29:52 -0400
Date: Mon, 17 Jul 2006 23:29:51 +0200
From: Ulrich Kunitz <kune@deine-taler.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/wireless/zd1211rw/: possible cleanups
Message-ID: <20060717212951.GC29824@p15091797.pureserver.info>
Mail-Followup-To: Daniel Drake <dsd@gentoo.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linville@tuxdriver.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060715003511.GE3633@stusta.de> <44BA3C59.9030503@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BA3C59.9030503@gentoo.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-07-16 14:17 Daniel Drake wrote:

> Adrian Bunk wrote:
> >This patch contains the following possible cleanups:
> >- make needlessly global functions static
> >- #if 0 unused functions
> >
> >Please review which of these functions do make sense and which do 
> >conflict with pending patches.
> 
> Thanks Adrian. I have put this in my tree and made an additional change 
> along the same lines (your patched introduced an unused function warning 
> to the non-debug build). If Ulrich signifies acceptance, I will send 
> this on to John.
> 
> I have also sent in a patch to add a MAINTAINERS entry for zd1211rw, in 
> hope that this will help you send patches with myself and/or Ulrich CC'd 
> in future :)
> 
> Thanks.
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Adrian, I would like to see this patch split up into three at
least. 

Patch 1: Remove unused IO emulation functions
Patch 2: Remove other unused stuff, which could be split up
         further for each C file and header
Patch 3: Change DEBUG ifdefs to #if 0

The purpose of patch 3 is bogus, because the follow-up patch will
be called "removed useless #if 0 stuff". Keep in mind there is
some reason, why I have such code there. If they ifdefs are not
acceptable I will make this code dependent on a module parameter
and compile it into the production module. We have a lot of
different devices from different vendors out there and people
report "stuff isn't working" but almost nothing more.

The problem with patch 1 and 2 is, that almost all of the function
are completing the interface and some of them are even only static
inlines. They are there because they should be used, before
somebody reinvents the wheel or makes something completely stupid.
However if such reasoning is not acceptable I'm ready to
compromise.

-- 
Uli Kunitz
