Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290500AbSBLRWu>; Tue, 12 Feb 2002 12:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290503AbSBLRWo>; Tue, 12 Feb 2002 12:22:44 -0500
Received: from dsl-213-023-043-038.arcor-ip.net ([213.23.43.38]:60032 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290500AbSBLRVk>;
	Tue, 12 Feb 2002 12:21:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: How to check the kernel compile options ?
Date: Tue, 12 Feb 2002 18:23:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020212113237.5657B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020212113237.5657B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ageE-0001Te-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> On Tue, 12 Feb 2002, Daniel Phillips wrote:
> 
> > On February 11, 2002 08:05 pm, Bill Davidsen wrote:
> 
> > > Did I miss discussion of an option to put it somewhere other than as part
> > > of the kernel? Sorry, I missed that.
> > 
> > It's a trick question?  The config option would let you specify that no 
> > kernel config information at all would be stored with or in the kernel.  No 
> > cost, no memory footprint.  And I would get to have the extra warm n fuzzy 
> > usability I tend to go on at such lengths about.  So we're both happy, right? 
> > 
> > I'd even remain happy if the option were set *off* by default.
> 
> No trick other than to read what I said in either of the previous posts...
> the question was not how to avoid having the useful feature, but how to
> put it somewhere to avoid increasing the kernel size. I suggested in the
> modules directory, either as a text file or as a module.

We are in violent agreement, I'm not sure where the misunderstanding came from.
Yes, the leading idea is to put it in a module.  In fact a patch exists, though
it may have issues, it's been a while since I looked at it.

Besides that, it's been suggested to stick it only the end of bzImage in a way
that some utility can find it, so that it never gets loaded into memory or does
and is immediately discarded.  Bootfs might be another way to go, or maybe
that's just a way of making the module solution more elegant.  Personally, I
think that making it a module is obviously the right way to go.  The exact
details of how the module would work haven't been hashed out yet, at least,
not recently.  I presume the module should be compressed.  Perhaps it should
only work in conjunction with some user space utility, allowing the config
info to be expressed even more compactly than otherwise possible.  There is a
lot of room for creative compression here - I roughed out a design at one point
that would be able to represent the config information in something like a
couple hundred bytes, when the compile is from a standard tree.  This is cute,
but it's probably more cute than necessary.

> Disabling the feature is not the same as making it work optimally.
> I like making it a module because it's obvious that modules_install is
> needed. I see zero added utility from having it part of the kernel or
> nothing, it's useful even to people booting from ROM, small /boot
> partitions, etc.

OK, my apologies for misinterpreting your position.

-- 
Daniel
