Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUHVB3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUHVB3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 21:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUHVB3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 21:29:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32660 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265029AbUHVB3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 21:29:22 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8.1-mm3
Date: Sat, 21 Aug 2004 18:27:45 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
References: <20040820031919.413d0a95.akpm@osdl.org> <4126A4DC.1050103@yahoo.com.au> <200408211605.50975.jbarnes@engr.sgi.com>
In-Reply-To: <200408211605.50975.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408211827.46591.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2004 1:05 pm, Jesse Barnes wrote:
> On Friday, August 20, 2004 9:26 pm, Nick Piggin wrote:
> > Jesse Barnes wrote:
> > > On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
> > >>- This is (very) lightly tested.  Mainly a resync with various parties.
> > >
> > > Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run
> > > the profiles and try wli's new per-cpu profiling buffers.
> >
> > What changes were needed to achieve this previously?
>
> The arch specific SD_NODE_INIT was the missing piece from previous -mm
> releases.  Now that it's there, things seem to work.  I still have to poke
> around to see if there are places where we're trying to scan across all
> CPUs looking for busy ones and *then* checking to see if they're in a
> domain. John said he'd take a closer look.

It looks like the group span code will still try to look at everything in the 
system.  That'll also have to be fixed to use the span from the associated 
node's domain, since it looks like there are still places where we'll walk 
all the CPUs in the system if it's not.  I'll take a closer look and see if I 
can come up with something useful.

Thanks,
Jesse
