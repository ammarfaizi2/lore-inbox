Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWCXVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWCXVZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWCXVZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:25:55 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:36739
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932506AbWCXVZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:25:54 -0500
Date: Fri, 24 Mar 2006 13:25:26 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the e820 table
Message-ID: <20060324212526.GA4545@kroah.com>
References: <1143138170.3147.43.camel@laptopd505.fenrus.org> <200603231856.12227.ak@suse.de> <1143140539.3147.44.camel@laptopd505.fenrus.org> <1143141320.3147.47.camel@laptopd505.fenrus.org> <p73k6ak593d.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k6ak593d.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 01:19:02PM +0100, Andi Kleen wrote:
> Arjan van de Ven <arjan@linux.intel.com> writes:
> 
> > On Thu, 2006-03-23 at 20:02 +0100, Arjan van de Ven wrote:
> > > > That is e820_mapped(address, address+size, E820_RESERVED)
> > > > 
> > > > And not having a size is definitely wrong on i386 too.
> > > 
> > > s/wrong/not selective enough/
> > > 
> > > and e820_mapped doesn't check this either anyway, at least not the way
> > > you imply it does.
> > > 
> > > I'll do a new patch using this for x86_64 though, no need to make a
> > > second function like this.
> > 
> > 
> > There have been several machines that don't have a working MMCONFIG,
> > often because of a buggy MCFG table in the ACPI bios. This patch adds a
> > simple sanity check that detects a whole bunch of these cases, and when
> > it detects it, linux now boots rather than crash-and-burns. The accuracy
> > of this detection can in principle be improved if there was a "is this
> > entire range in e820 with THIS attribute", but no such function exist
> > and the complexity needed for this is not really worth it; this simple
> > check already catches most cases anyway.
> 
> I added the patch to my patchkit now. I also have an older patch (needs a bit
> more cleanup) that checks for all busses if they are reachable using MCFG
> Still needs some more work and interaction check with PCI hotplug though.

If you need help with that, please let me know.

Otherwise I'll let you push this to Linus when you feel it's ready :)

thanks,

greg k-h
