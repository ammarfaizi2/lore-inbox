Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUGAEM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUGAEM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 00:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGAEM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 00:12:56 -0400
Received: from mail.shareable.org ([81.29.64.88]:49325 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263943AbUGAEMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 00:12:52 -0400
Date: Thu, 1 Jul 2004 05:11:59 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701041158.GE1564@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> Just for kicks, I ran this on Mac OS X too :-D  Interesting results!
> Requested PROT | ---    R--    -W-    RW-    --X    R-X    -WX    RWX
> ========================================================================
> MAP_SHARED     | ---    r-x    ---    rwx    ---    r-x    ---    rwx
> MAP_PRIVATE    | ---    r-x    ---    rwx    ---    r-x    ---    rwx

Yikes.  I wonder if those results are correct.

To be honest, if those results are correct it looks like a MacOS X
bug, or at least POSIX non-conformance.  It should always grant a
superset of the requested protections.

That invalidates the portability rule "ask for the permissions you
need to use".  If you only need to write or execute a file, and you
only ask for those, MacOS X won't let you.  So the rule needs to be
"and always include PROT_READ in the list".  Assuming it's not a bug
in the test program.

By the way, my program is potentially slightly flaky on architectures
where the CPU can't do byte writes (such as old Alphas).  Depending on
the OS, the program might say write access isn't granted for a
write-only request, when it is.  The program should've done a word
write instead.

I doubt that is the cause of those results on a PPC running MacOS X though :)

Can you confirm in a simple way that mapping a file, or some anonymous
memory, without PROT_READ, really isn't writable under MacOS X?  Can
you confirm it with a word write, if that would be relevant?

Cheers,
-- Jamie
