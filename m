Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315537AbSECCbn>; Thu, 2 May 2002 22:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315538AbSECCbm>; Thu, 2 May 2002 22:31:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28612 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315537AbSECCbl>;
	Thu, 2 May 2002 22:31:41 -0400
Date: Thu, 2 May 2002 22:31:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: John Covici <covici@ccs.covici.com>
cc: Dave Jones <davej@suse.de>, tomas szepe <kala@pinerecords.com>,
        Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <Pine.LNX.4.40.0205022117350.17239-100000@ccs.covici.com>
Message-ID: <Pine.GSO.4.21.0205022217290.17171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2002, John Covici wrote:

> So what should it point to?  I have had more trouble when some Debian
> package made it not a symlink and if I tried to compile something

"some package" being libc6-dev.  I.e. the first thing that puts something
in /usr/include...

> which needed correct headers for the version I am using I get very
> strange errors which are hard to diagnose.

Fix your application.  The rules are very simple - /usr/include/linux contains
versions of headers used to build libc.  If you are linking against libc,
you don't want to have different parts of resulting executable to be
compiled with different versions of these headers.  If you want several
definitions from headers of your current kernel - extract them (and make
damn sure that you don't pull a conflict with libc headers).

IOW, create a private header with definitions you need.  And you'd better
make sure that stuff you are pulling is stable, obviously - if it changes
from version to version you are going to run into serious trouble at
runtime.  "Rebuild whenever you boot into new kernel" is not a good idea...

