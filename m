Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbREYTDe>; Fri, 25 May 2001 15:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbREYTDY>; Fri, 25 May 2001 15:03:24 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37078 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261696AbREYTDH>; Fri, 25 May 2001 15:03:07 -0400
Date: Fri, 25 May 2001 20:02:53 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
Message-ID: <20010525200253.M7952@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0105251100180.949-100000@penguin.transmeta.com> <Pine.GSO.4.21.0105251415400.27664-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0105251415400.27664-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, May 25, 2001 at 02:24:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 25, 2001 at 02:24:52PM -0400, Alexander Viro wrote:

> If you are OK with adding two extra arguments to ->readpage() I could
> submit a patch replacing that with plain and simple page cache by tomorrow.
> It should not be a problem to port, but I want to get some sleep before
> testing it...

The problem will be returning the IO completion status.  We can't just
rely on PG_Error: what happens if two separate partial reads are
submitted at once within the same page, yet the page is not completely
in cache?  If we forced readpage to be synchronous in that case we
could just return the status directly.  Otherwise we need a separate
way of determining the completion status once the page becomes
unlocked (eg. have a special readpage return which means "all done,
completion status is X", and resubmit the readpage to get that
completion status once the page lock is dropped.)

--Stephen

