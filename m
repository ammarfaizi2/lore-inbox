Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVKPOdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVKPOdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbVKPOdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:33:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:7875 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030343AbVKPOdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:33:35 -0500
Date: Wed, 16 Nov 2005 08:33:13 -0600
From: Robin Holt <holt@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Paul Jackson <pj@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, steiner@sgi.com
Subject: Re: [PATCH] cpuset export symbols gpl
Message-ID: <20051116143313.GG4573@lnx-holt.americas.sgi.com>
References: <20051116012254.6470.89326.sendpatchset@jackhammer.engr.sgi.com> <20051115173935.5fc75e00.akpm@osdl.org> <20051115180336.11139847.pj@sgi.com> <20051116081627.GA20555@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116081627.GA20555@infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 08:16:27AM +0000, Christoph Hellwig wrote:
> On Tue, Nov 15, 2005 at 06:03:36PM -0800, Paul Jackson wrote:
> > Andrew wrote (of exporting cpuset symbols)
> > > We normally would do this when such modules are merged.  Do tell us more..
> > 
> > It was an oversight not to do this when cpusets went in last year,
> > but we didn't notice, as the loadable module we cared about had a
> > hack in place from earlier development that avoided needing this.
> > 
> > In cleaning this up, we realized that the module needed to access
> > task->cpuset->cpus_allowed, and that the correct (and safe) way to
> > do this, via cpuset_cpus_allowed(), was not available to the module.
> > 
> > The other 4 exports I added on general principles, but don't have
> > any pressing need for.  The one I need is cpuset_cpus_allowed().
> > 
> > The loadable module in question we call 'dplace', and is used to
> > provide fancier cpuset-relative task placement by manipulating
> > task->cpus_allowed at exec.
> 
> Again, where is the module.  Please submit the change to export the
> symbols in the same patch series as that module.  And honestly I don't
> think it'll survive review when it's poking that deeply into cpuset
> internals, but we'll see how to do it properly once it's sent here.

I would argue that it does not dig deeply enough.  I think it would be
better to expand dplace to handle early-for activity.  It would be nice
to get a hook in do_fork before the call to copy_process so we can place
the child task struct on the destination instead of the source node.

That said, I could swear that dplace or something that looks a lot like
dplace was already posted on lkml, but I did not find it when I searched.
Maybe my archive is missing some stuff.

Robin
