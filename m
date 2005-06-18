Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVFRGDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVFRGDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 02:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVFRGDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 02:03:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262066AbVFRGDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 02:03:38 -0400
Date: Fri, 17 Jun 2005 23:05:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12 
In-Reply-To: <21446.1119073126@ocs3.ocs.com.au>
Message-ID: <Pine.LNX.4.58.0506172255280.2268@ppc970.osdl.org>
References: <21446.1119073126@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jun 2005, Keith Owens wrote:
> On Fri, 17 Jun 2005 22:13:25 -0700 (PDT), 
> Linus Torvalds <torvalds@osdl.org> wrote:
> >As some people may have noticed already, 2.6.12 is out there now.
> 
> tar xjvf linux-2.6.12.tar.bz2, using SuSE tar-1.13.25-325.3 on IA64,
> reports
> 
> tar: pax_global_header: Unknown file type 'g', extracted as normal file
> 
> It does not seem to cause any problems.

Yes, git creates tar-archives that use the extended pax headers, and I 
think you need tar-1.14 to fully understand them. They should not hurt 
(apart from the warning) on older versions of tar.

The extended header just contains a hidden comment record that tells the
git commit ID that was used to generate the tar-tree.

Because it's extracted as a regular file (instead of tar knowing that it's 
a comment header), you will now have a file called "pax_global_header" 
that has the contents

	52 comment=9ee1c939d1cb936b1f98e8d81aeffab57bae46ab

in it (where "9ee1c939d1cb936b1f98e8d81aeffab57bae46ab" is the git SHA1
name of the Linux-2.6.12 commit).

So it's not entirely "harmless" in that it causes a bogus file to be
created, but it's not like it's a huge problem either, and that bogus file
actually does contain real information (although it's not useful unless
you're a git user).

			Linus
