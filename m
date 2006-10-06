Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932672AbWJFG76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWJFG76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 02:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbWJFG76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 02:59:58 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:19356 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932672AbWJFG75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 02:59:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Jrj2Wlc4B2EDPNR7SWWVSx79GSSztwXxxhEo9VuMGvIgl7NA5MxJddBflCqFVREthfhd5MNGQ+oScnREpep06k3Q13Tdy4PJ8dUFrC3c8+OIOXU9uDt7F5jSsSqmkqs+DV44zVRlDu/UVCARvSJzEK0sHVv50/JKNiyWwrgjE2w=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Dave Jones <davej@redhat.com>
Subject: Re: [2.6.19-rc1][AGP] Regression -  amd_k7_agp  no longer detected
Date: Fri, 6 Oct 2006 02:59:52 -0400
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
References: <200610060150.20415.shawn.starr@rogers.com> <20061006060803.GB3381@redhat.com>
In-Reply-To: <20061006060803.GB3381@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060259.52742.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 2:08 am, Dave Jones wrote:
> On Fri, Oct 06, 2006 at 01:50:19AM -0400, Shawn Starr wrote:
>  > When loading amd_k7_agp nothing appears from kernel, no information
>  > about the AGP chipset/aptreture size etc. Even putting kprints inside
>  > the probe() function of the driver does not get called.
>
> Even as the first thing in agp_amdk7_probe() ?

Nada, nothing appears even if I put a printk before we do any actual probing.

> What is pci_register_driver returning ?

Don't know yet. II didn't yet walk agp_amdk7_init() and dump out the values 
yet.

> When we modprobe the chipset driver, and run through the ->probe, it's all
> pci layer stuff really, up until we agp_alloc_bridge(). But if you're not
> getting that far, the core agpgart stuff doesn't even come into play.

> It's something of a mystery to me as that driver hasn't changed in ages
> asides from spelling fixes and other trivialities.

It does appear to be PCI. Yes, I don't see any significant changes in the agp 
code (other than the one mentioned below)

> Damn, that's going back a bit..
> But again, this driver hasn't really changed much since 2.5.x, so I'm
> wondering if this is a side-effect of some change in another subsystem.
> Can you narrow it down to a specific kernel version where it broke ?
> 2.6.15 -> 2.6.18 is such a huge delta it's not even worth looking at.
> Narrow the scope, and I'll eyeball the pci changes etc.

> I don't have any AMD hardware to test any more, so I've no chance of
> trying to reproduce this.  All I can suggest is to try and narrow
> down where it's failing, and then maybe I'll have enough clues to hazard
> a guess at the cause.

I'm going to do some git bisect fun (best time to learn how to do it) and 
narrow this down later when I get back from work. We should find the cuprate 
later today.

>  > Looking at the differences, I noticed some changes in generic.c for
>  > determing the AGP speed. I don't know if this has anything to do with
>  > this breaking. This video card is a Radeon 7500 AiW 64MB DDR and can do
>  > AGP4x and BIOS has AGP4x turned on by default. But this all would fail
>  > even before X is started if agpgart finds no chipset.
>
> That code runs later when /dev/agpgart is open()'d, so it shouldn't
> affect this. It shouldn't be hard to revert though if you want to
> try it.  Also, that only changed the AGPx8 path, which no K7 chipsets can
> do. If you ended up running that code, something is deeply screwed.

> 	Dave

I can certainly do a quick debug on that to confirm if it is or not hitting 
that code path later today.

Thanks Dave. I'll provide you more info once I narrow things down a bit.

Shawn.
