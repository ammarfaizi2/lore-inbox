Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVE1VuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVE1VuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 17:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVE1VuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 17:50:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261184AbVE1VuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 17:50:19 -0400
Date: Sat, 28 May 2005 17:50:05 -0400
From: Dave Jones <davej@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, David Airlie <airlied@linux.ie>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
Message-ID: <20050528215005.GA5990@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>, David Airlie <airlied@linux.ie>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.62.0505282333210.5800@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505282333210.5800@anakin>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 11:39:00PM +0200, Geert Uytterhoeven wrote:
 > 
 > DRM depending on `AGP=n' is driving me crazy! How to make CONFIG_DRM not
 > eligible for selection on platforms that do not have AGP?
 > 
 > Since many of the core DRM files depend on PCI, add a dependency on PCI,
 > to minimize the damage.
 > 
 > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
 > 
 > --- linux-2.6.12-rc5/drivers/char/drm/Kconfig	2005-05-25 19:37:53.000000000 +0200
 > +++ linux-m68k-2.6.12-rc5/drivers/char/drm/Kconfig	2005-04-05 10:12:41.000000000 +0200
 > @@ -6,7 +6,7 @@
 >  #
 >  config DRM
 >  	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 > -	depends on AGP || AGP=n
 > +	depends on (AGP || AGP=n) && PCI

The whole dependancy seems like nonsense to me.
I think

	depends on PCI

is a lot more sensible.

		Dave

