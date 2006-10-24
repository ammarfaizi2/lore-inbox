Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWJXWa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWJXWa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 18:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWJXWa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 18:30:28 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:4268 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161289AbWJXWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 18:30:27 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061024221950.GB5851@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz>
	 <1161728153.22729.22.camel@nigel.suspend2.net>
	 <20061024221950.GB5851@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:30:27 +1000
Message-Id: <1161729027.22729.37.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-10-25 at 00:19 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > > Switch from bitmaps to using extents to record what swap is allocated;
> > > > > they make more efficient use of memory, particularly where the allocated
> > > > > storage is small and the swap space is large.
> > > > 
> > > > As I said before, I like the overall idea, but I have a bunch of
> > > > comments.
> > > 
> > > Okay, if Rafael likes it... lets take a look.
> > > 
> > > First... what is the _worst case_ overhead? AFAICT extents are very
> > > good at the best case, but tend to suck for the worst case...?
> > 
> > That's right. In using this, we're relying on the fact that the swap
> > allocator tries to act sensibly. I've only seen worse case performance
> > when a user had two swap devices with the same priority (striped), but
> > that was a bug. :)
> 
> Ok, but if the allocator somehow manages to stripe between two swap
> devices, what happens?
> 
> IIRC original code was something like .1% overhead (8bytes per 4K, or
> something?), bitmaps should be even better. If it is 1% in worst case,
> that's probably okay, but it would be bad if it had overhead bigger
> than 10times original code (worst case).

With the code I have in Suspend2 (which is what I'm working towards),
the value includes the swap_type, so there's no overlap. Assuming the
swap allocator does it's normal thing and swap allocated is contiguous,
you'll probably end up with two extents: one containing the swap
allocated on the first device, and the other containing the swap
allocated on the second device. So (with the current version), striping
would use 6 * sizeof(unsigned long) instead of 3 * sizeof(unsigned
long).

Regards,

Nigel

