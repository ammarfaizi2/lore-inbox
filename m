Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUAMQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAMQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 11:26:43 -0500
Received: from unthought.net ([212.97.129.88]:15287 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264368AbUAMQ0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 11:26:38 -0500
Date: Tue, 13 Jan 2004 17:26:36 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Scott Long <scott_long@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040113162636.GT346@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
References: <40033D02.8000207@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40033D02.8000207@adaptec.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 05:34:10PM -0700, Scott Long wrote:
> All,
> 
> Adaptec has been looking at the MD driver for a foundation for their
> Open-Source software RAID stack.  This will help us provide full
> and open support for current and future Adaptec RAID products (as
> opposed to the limited support through closed drivers that we have now).

Interesting...

> 
> While MD is fairly functional and clean, there are a number of 
> enhancements to it that we have been working on for a while and would
> like to push out to the community for review and integration.  These
> include:
> 
> - partition support for md devices:  MD does not support the concept of
>   fdisk partitions; the only way to approximate this right now is by
>   creating multiple arrays on the same media.  Fixing this is required
>   for not only feature-completeness, but to allow our BIOS to recognise
>   the partitions on an array and properly boot them as it would boot a
>   normal disk.

This change is probably not going to go into 2.6.X anytime soon anyway,
so what's your thoughts on doing this "right" - getting MD moved into
DM ?

That would solve the problem, as I see it.

I'm not currently involved in either of those development efforts, but I
thought I'd bring your attention to the DM/MD issue - there was some
talk about it in the past.

Also, since DM will do on-line resizing and we want MD to do this as
well some day, I really think this is the way to be going.  Getting
partition support on MD devices will solve a problem now, but for the
long run I really think MD should be a part of DM.

Anyway, that's my 0.02 Euro on that issue.

...
> - Metadata abstraction:  We intend to support multiple on-disk metadata
>   formats, along with the 'native MD' format.  To do this, specific
>   knowledge of MD on-disk structures must be abstracted out of the core
>   and personalities modules.

I think this one touches the DM issue as well.

So, how about Adaptec and IBM get someone to move MD into DM, and while
you're at it, add hot resizing and hot conversion between RAID levels  :)

2.7.1?  ;)

Jokes aside, I'd like to hear your oppinions on this longer-term
perspective on things...

The RAID conversion/resize code for userspace exists already, and it
works except for some cases with RAID-5 and disks of non-equal size,
where it breaks horribly (fixable bug though).


 / jakob

