Return-Path: <linux-kernel-owner+w=401wt.eu-S932456AbXAGJbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbXAGJbL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbXAGJbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:31:11 -0500
Received: from 1wt.eu ([62.212.114.60]:1815 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456AbXAGJbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:31:10 -0500
Date: Sun, 7 Jan 2007 10:30:57 +0100
From: Willy Tarreau <w@1wt.eu>
To: Steve Brueggeman <xioborg@mchsi.com>
Cc: Auke Kok <sofar@foo-projects.org>, Akula2 <akula2.shark@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
Message-ID: <20070107093057.GS24090@1wt.eu>
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com> <459D9872.8090603@foo-projects.org> <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:28:12PM -0600, Steve Brueggeman wrote:
> There are some difficulties with gcc versions between linux-2.4 and linux-2.6,
> but I do not recall all of the details off of the top of my head.  If I recall
> correctly, one of the issues is, linux-2.4 ?prefers? gcc-2.96, while newer
> linux-2.6 support/prefer gcc-3.? or greater.

2.4 was designed for gcc 2.95.3 and supports gcc up to 3.4 on all platforms,
and up to 4.1 on x86, x86_64, ppc and sparc64. Recent gcc 3.4 produces good
code on 2.4, and is able to efficiently optimize for size (-Os) without too
much speed compromise.

> At any rate, what I've done is create a chroot environment.  I created this
> chroot directory by installing an older distribution that was created with
> linux-2.4 in mind (example, RedHat v8.2) into that at chroot directory.  The
> easiest way to do this that I'm aware of is to install the older distribution
> (minimal development, no server junk, no X junk) on another computer, then copy
> from that computer to a directory on your development computer.

Hmm, I think you did it the *hard* way. Gcc has been supporting
multi-version for years. You just have to compile it with --suffix=-3.4
or --suffix=4.1 to have a whole collection of gcc versions on your host.
If you don't want to recompile gcc, simply rename the binaries and you're
OK. When you build, you only have to do :

  $ make bzImage modules CC=gcc-3.4

I've been using it like this for years without problem. It's really
convenient, and it also allows you to easily compare output codes and
sizes between compilers.

Regards,
Willy

