Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTEOXBx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTEOXBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:01:52 -0400
Received: from smtp1.server.rpi.edu ([128.113.2.1]:19086 "EHLO
	smtp1.server.rpi.edu") by vger.kernel.org with ESMTP
	id S264305AbTEOXBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:01:45 -0400
Mime-Version: 1.0
Message-Id: <p05210620bae9cce008ed@[128.113.24.47]>
In-Reply-To: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
Date: Thu, 15 May 2003 19:14:27 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: [OpenAFS-devel] Re: Alternative to PAGs
Cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:53 AM -0700 5/15/03, Linus Torvalds wrote:
>On Thu, 15 May 2003, David Howells wrote:
>  >
>  >   (4) A user has to be able to override the default keyring,
>  >       such that they can, for instance, perform operations
>  >       on a remote filesystem with a different credential.
>
>I disagree. Your (4) comes from your (1) - inability to have
>multiple keyrings. If you have multiple keyrings, you don't
>"override" anything.   You just have a stacking order (ie the
>credentials is a _sorted_ list of  keyrings), and you search
>the credentials for valid keys in order.

I am not completely sure what David meant.  I think I agree
with what he meant, but would argue with your assumption.

A process can be both drosehn@rpi.edu and gad@umich.edu at
the same moment.  By being drosehn@rpi.edu, I'm also in any
number of AFS groups at RPI (a number that I have no knowledge
of or control over).

What AFS does not want is for a single process to be drosehn@rpi.edu
and linus@rpi.edu at the exact same time.  That is to avoid the
question of what open() should do on a file which is permitted:

     drosehn rlidwka
     linus   none

The above says linus@rpi.edu should have absolutely no access to
the file, no matter what AFS or unix groups he is in.  At the same
time, drosehn@rpi.edu has complete access to the file.  If the
process claims to be both of those users, then what is open()
to do?  In the pure-unix world, is a process both userid linus
and userid drosehn?  No.  (it might have different values for
userid and effectiveUserid, but it only has one value for userid
and only one value for effectiveUserid).

You could argue that open() should give access, or that it should
not give access, but my point is that the limitation against being
multiple AFS users at a single time is to avoid that question.
It was not the side-effect of some other decision.

*1 = Actually, in afs the permissions are on a directory level,
      but I'd agree that they *should* be on the file level, and
      thus I said it that way...

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
