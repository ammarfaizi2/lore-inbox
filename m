Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270087AbRHGFzg>; Tue, 7 Aug 2001 01:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270088AbRHGFz1>; Tue, 7 Aug 2001 01:55:27 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:23680 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S270087AbRHGFzJ>;
	Tue, 7 Aug 2001 01:55:09 -0400
Date: Mon, 6 Aug 2001 22:55:19 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently some of you have missed the point.  Currently, the only way to
write any form of encryption application is to have it run setuid root so
it can lock pages in RAM.  Otherwise, files (or keys) that are encrypted
on disk may be left in an unencrypted state on swap, allowing for
potential recovery by anyone with hardware access.  Encrypted swap makes
locking pages unnecessary, which relieves many sysadmins from the anxiety
of having yet-another-setuid application installed on their server in
addition to freeing up additional pages to be swapped.

Many of you seem to think that having hardware access forfeits any
expected security, however this is not the case.  Data in hardware RAM is
not accessible to anyone but the user and root at the time the application
is running.  If the system is physically compromised, there is little way
I can think of to take root without having to at least reboot the
computer, thus destroying the unencrypted contents of RAM.

Personally, I don't run out of actual RAM often, thus keeping my swap-file
on an encrypted loopback is satisfactory.  I would imagine that this
incurs a significant overhead which may be unacceptable for swap-heavy
systems.  If Linux supported encrypted swap directly, it would reduce this
overhead by eliminating the fs layer from memory access.  I think this
would be a good thing, and should probably be suggested to the
international kernel group, since they're probably the most interested.

-Ryan

