Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266709AbUBGJsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266710AbUBGJsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:48:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43935 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266709AbUBGJsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:48:52 -0500
Date: Sat, 7 Feb 2004 09:48:47 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       viro@math.psu.edu
Subject: Re: PATCH - raise max_anon limit
Message-ID: <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
References: <20040206221545.GD9155@sun.com> <20040207005505.784307b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207005505.784307b8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:55:05AM -0800, Andrew Morton wrote:
> Tim Hockin <thockin@sun.com> wrote:
> >
> > Attached is a patch to raise the limit of anonymous block devices.  The
> >  sysctl allows the admin to set the order of pages allocated for the unnamed
> >  bitmap from 1 page to the full MINORBITS limit.
> 
> It would be better to lose the sysctl and do it all dynamically.
> 
> Options are:
> 
> a) realloc the bitmap when it fills up
> 
>    Simple, a bit crufty, doesn't release memory.
> 
> b) lib/radix-tree.c
> 
>    Each entry in the radix tree can be a bitmap (radix-tree.c should
>    have been defined to store unsigned longs, not void*'s.  Oh well), so
>    you get good space utilisation, but finding a new entry will take ten or
>    so lines of code.
> 
> c) lib/idr.c
> 
>    Worst space utilisation, but simplest code.

d) grab a couple of pages and be done with that.  That gives us 64Kbits.

e) grab max(1/8000 of entire memory, 128Kb).  That will guarantee that
we run out of memory or minors before we fill the bitmap.

PS: psu.edu address is still valid, but I rarely read that mailbox...
