Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136159AbRD0SSW>; Fri, 27 Apr 2001 14:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136152AbRD0SSM>; Fri, 27 Apr 2001 14:18:12 -0400
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:6157
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S136156AbRD0SSA>; Fri, 27 Apr 2001 14:18:00 -0400
Date: Fri, 27 Apr 2001 11:17:53 -0700
From: dek_ml@konerding.com
To: LA Walsh <law@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427111753.A26593@konerding.com>
In-Reply-To: <200104262113.XAA01552@kufel.dom> <3AE9B429.6CCEF680@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE9B429.6CCEF680@sgi.com>; from law@sgi.com on Fri, Apr 27, 2001 at 11:02:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2001 at 11:02:17AM -0700, LA Walsh wrote:
> Andrzej Krzysztofowicz wrote:
> 
> > I know a few people that often do:
> >
> > dd if=/dev/hda1 of=/dev/hdc1
> > e2fsck /dev/hdc1
> >
> > to make an "exact" copy of a currently working system.
> 
> ---
>     Presumably this isn't a problem is the source disks are either unmounted or mounted 'read-only' ?
> 
> 

I thought the known best solution on this was to use COW snapshots,
because then you copy the filesystem as exactly the state when the snapshot
was made, without impacting the writability of the filesystem while
the (potentially very long) dump is made?

I tried using this on LVM, but after seeing a few messages on the list about
kernel oopses happening with snapshots of filesystems with heavy write
activities, as well as experiencing serious problems with the LVM userspace
tools (they would core dump on startup if the LVM filesystem had any sort
of corruption or integrity failure) I decided to put it away until the LVM
folks managed to get a production version ready.
