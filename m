Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRFTPv2>; Wed, 20 Jun 2001 11:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261960AbRFTPvJ>; Wed, 20 Jun 2001 11:51:09 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:37809 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S261639AbRFTPvG>; Wed, 20 Jun 2001 11:51:06 -0400
Date: Wed, 20 Jun 2001 16:52:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Tridgell <tridge@valinux.com>
cc: Linus Torvalds <torvalds@transmeta.com>, davem@redhat.com,
        zackw@stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.2 PATCH: check return from copy_*_user in fs/pipe.c
In-Reply-To: <20010620043348.9B597474B@lists.samba.org>
Message-ID: <Pine.LNX.4.21.0106201604220.2060-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Andrew Tridgell wrote:
> Davem wrote:
> >  > The anonymous pipe code in 2.2 does not check the return value of
> >  > copy_*_user.  This can lead to silent loss of data.
> 
> Linus didn't want to fix it in pipe.c until copy_from_user was fixed
> on all architectures to zero any parts of the destination that were
> not written to (due to the source being invalid). He didn't want us to
> fix just this one case and then forget about fixing the general case
> by fixing copy_*_user.

Thanks for shedding light on this, I was curious about that zeroing.
Please correct my understanding if I'm wrong to say:

1. If all copy_from_user() callers checked the residue returned and
   acted appropriately, there would be no need for such zeroing;
2. Usually Linux prefers to fix all the abusers of a macro or
   function, rather than adding extra safety checks within it;
3. But here, the security risk, the ease of abuse, and the difficulty
   in auditing all uses (more each day), led to this zeroing within?

May your source never be invalid,
Hugh

