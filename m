Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUDGWWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUDGWWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:22:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:939 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261186AbUDGWWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:22:07 -0400
Date: Wed, 07 Apr 2004 15:33:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Kravetz <kravetz@us.ibm.com>
cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [patch 0/3] memory hotplug prototype
Message-ID: <3840000.1081377218@flay>
In-Reply-To: <20040407185953.GC4292@w-mikek2.beaverton.ibm.com>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp> <29700000.1081361575@flay> <20040407185953.GC4292@w-mikek2.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, April 07, 2004 11:59:53 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:

> On Wed, Apr 07, 2004 at 11:12:55AM -0700, Martin J. Bligh wrote:
>> > This is an updated version of memory hotplug prototype patch, which I
>> > have posted here several times.
>> 
>> I really, really suggest you take a look at Dave McCracken's work, which
>> he posted as "Basic nonlinear for x86" recently. It's going to be much
>> much easier to use this abstraction than creating 1000s of zones ...
>> 
> 
> I agree.  However, one could argue that taking a zone offline is 'easier'
> than taking a 'section' offline: at least right now.  Note that I said
> easier NOT better.  Currently a section represents a subset of one or more
> zones.  Ideally, these sections represent units that can be added or
> removed.  IIRC these sections only define a range of physical memory.
> To determine if it is possible to take a section offline, one needs to
> dig into the zone(s) that the section may be associated with.  We'll
> have to do things like:
> - Stop allocations of pages associated with the section.
> - Grab all 'free pages' associated with the section.
> - Try to reclaim/free all pages associated with the section.
>   - Work on this until all pages in the section are not in use (or free).
>   - OR give up if we know we will not succeed.
> 
> My claim of zones being easier to work with today is due to the
> fact that zones contain much of the data/infrastructure to make
> these types of operations easy.  For example, in IWAMOTO's code a
> node/zone can be take offline when 'z->present_pages == z->free_pages'.

I really think the level of difference in difficultly here is trivial.
The hard bit is freeing the pages, not measuring them. I would suspect
altering the swap path to just not "free" the pages, but put them into
a pool for hotplug is fairly easy.

M.

