Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992778AbWJUBxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992778AbWJUBxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992781AbWJUBxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:53:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:1725 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992778AbWJUBxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:53:52 -0400
Date: Fri, 20 Oct 2006 17:48:45 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061021004845.GB12131@kroah.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl> <20061020091901.71a473e9.akpm@osdl.org> <200610201854.43893.m.kozlowski@tuxland.pl> <20061020102520.67b8c2ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020102520.67b8c2ab.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 10:25:20AM -0700, Andrew Morton wrote:
> On Fri, 20 Oct 2006 18:54:43 +0200
> Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:
> 
> > Hello, 
> > 
> > > Don't know. ? Nothing has changed in the git-pcmcia tree since July.
> > >
> > > Are you able to bisect it, as per
> > > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt ?
> > >
> > > > When running without debug options enabled also these were seen amongst
> > > > dmesg lines:
> > > >
> > > > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > > > [drm:drm_unlock] *ERROR* Process 5131 using kernel context 0
> > >
> > > <googles>
> > >
> > > This? http://lkml.org/lkml/2005/9/10/78
> > 
> > I think I found the culprit. It's CONFIG_PCI_MULTITHREAD_PROBE option. It is 
> > actually marked as EXPERIMENTAL and there is even a proper warning included 
> > on the help page. Disabling it makes the kernel behave the right way. So 
> > should what I reported be considered a real error or not? Then the next 
> > question is should I report errors caused by options marked as EXPERIMENTAL 
> > or just leave it the way it is until the option is not EXPERIMENTAL anymore?
> 
> Ow.  Multithreaded probing was probably a bt ambitious, given the current
> status of kernel startup..
> 
> Greg, does it actually speed anything up or anything else good?

Yes, it does speed up some people's boxes.  It's also found a few nice
race conditions that we need to fix up no matter what (MSI
initialization, dvb borkage, etc.)

But it is still quite experimental, hence the wording in the config
option.

Note that the next opensuse release will have this enabled, but it has
to have a kernel command line option added by the user in order for it
to be enabled.  It should get a lot more testing that way.

thanks,

greg k-h
