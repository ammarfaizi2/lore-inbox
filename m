Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbSLKWgT>; Wed, 11 Dec 2002 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbSLKWgC>; Wed, 11 Dec 2002 17:36:02 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:55558 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S267345AbSLKWeU>;
	Wed, 11 Dec 2002 17:34:20 -0500
Date: Wed, 11 Dec 2002 14:38:57 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: Olaf Dietsche <olaf.dietsche@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capable open_port() check wrong for kmem
Message-ID: <20021211223857.GA23741@net-ronin.org>
References: <20021210032242.GA17583@net-ronin.org> <87fzt6nm6n.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzt6nm6n.fsf@goat.bogus.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 12:33:04PM +0100, Olaf Dietsche wrote:
[snip]
> You may want to look at this thread:
> <http://groups.google.com/groups?threadm=87smza1p7f.fsf%40goat.bogus.local>

Hmm.

Okay, which approach is generally accpetible for inclusion into the kernel?
1) Nuke CAP_SYS_RAWIO check.  If the permissions on /dev/kmem is wrong,
tough.  It shouldn't be root:root 0666 in the first place anyways.
2) Add CAP_SYS_KMEM for read-only access, check for CAP_SYS_RAWIO for
the write case.
3) Special case /dev/kmem in open_port.

or:

4) Even if an application doesn't need write access to /dev/kmem, require
it to open /dev/kmem O_RDWR, as  it makes life easier for many people,
especially when modifying the kernel at run-time to hijack sysca... um, do
creative updates. :)

I'd prefer #1 or #2, but the discussion seems to have ended during the last
time the issue was brought up.

-- DN
Daniel
