Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277424AbRJJVpn>; Wed, 10 Oct 2001 17:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277420AbRJJVpe>; Wed, 10 Oct 2001 17:45:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16089 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277424AbRJJVpU>;
	Wed, 10 Oct 2001 17:45:20 -0400
Date: Wed, 10 Oct 2001 17:45:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mingming cao <cmm@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
In-Reply-To: <3BC4E8AD.72F175E3@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0110101743140.21168-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, Mingming cao wrote:

> Hi Linus, Alan and Al,
> 
> I found that rmdir(2) could remove current working directory
> successfully.  This happens when the given pathname points to current
> working directory, not ".", but something else. For example, the current
> working directory's absolute pathname.  I read the man page of
> rmdir(2).  It says in this case EBUSY error should be returned.  I
> suspected this is a bug and added a check in vfs_rmdir(). The following
> patch is against 2.4.10 and has been verified.  Please comment and
> apply.

It's not a bug.  Moreover, test you add is obviously bogus - what about
cwd of other processes?

Actually, rmdir() on a busy directory _is_ OK.  Implementation is allowed
to refuse doing that, but it's not required to.

