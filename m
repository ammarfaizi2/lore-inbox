Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135396AbREDDKO>; Thu, 3 May 2001 23:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135403AbREDDKE>; Thu, 3 May 2001 23:10:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15702 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135396AbREDDJw>; Thu, 3 May 2001 23:09:52 -0400
Date: Fri, 4 May 2001 05:09:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeffrey Kuskin <jsk@atheros.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4+fork patch still sluggish
Message-ID: <20010504050933.B1902@athlon.random>
In-Reply-To: <15090.2067.861480.564724@byte.users.atheros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15090.2067.861480.564724@byte.users.atheros.com>; from jsk@atheros.com on Thu, May 03, 2001 at 06:38:27PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 06:38:27PM -0700, Jeffrey Kuskin wrote:
> This is basically a followup to the "2.4.4 sluggish under fork load"
> thread.
> 
> I am using Redhat 7.1 on a 128MB 400 MHz PII system.  I have a
> locally-built 2.4.4 kernel to which I manually applied the patch that backs
> out the child-before-parent behavior on a fork.  Namely, this patch:
> 
>   <http://boudicca.tux.org/hypermail/linux-kernel/2001week17/1288.html>
> 
> However, even with this patch applied, I still see extremley jerky mouse
> pointer behavior when I run any kind of job that does lots of forking.  For
> example, a kernel compile or even just the "configure" in preparation for
> compiling XEmacs.
> 
> The same behavior, on exactly the same machine, did _not_ occur with Redhat
> 6.2/kernel 2.2.19.
> 
> I see that this patch has recently been merged into 2.4.5-pre1, but I am
> concerned that it does actually fix the underlying problem.
> 
> Do others continue to see "jerky mouse pointer" behavior even with this
> patch installed, or should I look for other causes?  For instance, are
> there known problems with jerky mouse pointer behavior under heavy swapping
> load?

That's a bug in the get-child-timeslice logic that I mentioned a few
days ago.

Interesting strict fixes for this issue are here (they won't apply
cleanly to 2.4.5pre1 but fixing reject is trivial):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5pre1aa1/10_parent-timeslice-6
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5pre1aa1/20_share-timeslice-2

If you can reproduce on 2.4.5pre1aa1 let us know. Thanks!

Andrea
