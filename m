Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263604AbUD2GdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263604AbUD2GdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUD2GdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:33:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:24706 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263604AbUD2GdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:33:07 -0400
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, brettspamacct@fastclick.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040428232222.1be25448.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com>
	 <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com>
	 <40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org>
	 <16528.23219.17557.608276@cargo.ozlabs.ibm.com>
	 <20040428185342.0f61ed48.akpm@osdl.org>
	 <20040428194039.4b1f5d40.akpm@osdl.org>
	 <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
	 <1083219158.20089.128.camel@gaston> <20040428232222.1be25448.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083219952.29596.131.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 16:25:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 16:22, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > 
> > > The really strange thing is that the behaviour seems to get worse the
> > > more RAM you have.  I haven't noticed any problem at all on my laptop
> > > with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
> > > 2.6.2-rc3 though, so I will try a newer kernel on it.)
> > 
> > Your G5 also has a 2Gb IO hole in the middle of zone DMA, it's possible
> > that the accounting doesn't work properly.
> 
> heh.  It should have zone->spanned_pages - zone->present_pages = 2G.

That should be fine, I'll check later, I can't reboot mine right now.

I'm initializing the zone with free_area_init_node() and I _am_ passing
the hole size. Paul, also check if you have NUMA enabled in .config, it changes
the way zones are initialized, I may have gotten that case wrong.

Ben.


