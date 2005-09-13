Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVIMSge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVIMSge (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVIMSgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:36:33 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:44965
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S964975AbVIMSgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:36:32 -0400
Date: Tue, 13 Sep 2005 14:32:15 -0400
From: Sonny Rao <sonny@burdell.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.13-mm3
Message-ID: <20050913183215.GA28596@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	anton@samba.org, linuxppc64-dev@ozlabs.org
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912145435.GA4722@kevlar.burdell.org> <20050912125641.4b53553d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912125641.4b53553d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 12:56:41PM -0700, Andrew Morton wrote:
> Sonny Rao <sonny@burdell.org> wrote:
> >
> > On Mon, Sep 12, 2005 at 02:43:50AM -0700, Andrew Morton wrote:
> > <snip>
> > > - There are several performance tuning patches here which need careful
> > >   attention and testing.  (Does anyone do performance testing any more?)
> > <snip>
> > > 
> > >   - The size of the page allocator per-cpu magazines has been increased
> > > 
> > >   - The page allocator has been changed to use higher-order allocations
> > >     when batch-loading the per-cpu magazines.  This is intended to give
> > >     improved cache colouring effects however it might have the downside of
> > >     causing extra page allocator fragmentation.
> > > 
> > >   - The page allocator's per-cpu magazines have had their lower threshold
> > >     set to zero.  And we can't remember why it ever had a lower threshold.
> > > 
> > 
> > What would you like? The usual suspects:  SDET, dbench, kernbench ?
> > 
> 
> That would be a good start, thanks.  The higher-order-allocations thing is
> mainly targeted at big-iron numerical computing I believe.
> 
> I've already had one report of fragmentation-derived page allocator
> failures (http://bugzilla.kernel.org/show_bug.cgi?id=5229).

Ok, I'm getting much further on ppc64 thanks to Anton B.

So far, I need patched in the hvc console fix, Anton's SCSI fix for
2.6.14-rc1, Paulus's EEH fix, and I reverted
remove-near-all-bugs-in-mm-mempolicyc.patch and
convert-mempolicies-to-nodemask_t.patch

I got most of the way through the boot scripts and crashed while
bringing up the loopback interface.

Here's the latest PPC64 crash on 2.6.13-mm3:

smp_call_function on cpu 5: other cpus not responding (5)
cpu 0x5: Vector: 0  at [c00000000f3b6b00]
    pc: 000000000000003d
    lr: 000000000000003d
    sp: c00000000f3b6a90
   msr: 8000000000009032
  current = 0xc000000002018050
  paca    = 0xc00000000048a400
    pid   = 1679, comm = ip
enter ? for help
5:mon> t

(xmon hangs here)

Anyone have ideas on what to try?
