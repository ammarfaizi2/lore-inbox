Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277471AbRJJWFf>; Wed, 10 Oct 2001 18:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277440AbRJJWF0>; Wed, 10 Oct 2001 18:05:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21181 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277437AbRJJWFV>; Wed, 10 Oct 2001 18:05:21 -0400
Message-ID: <3BC4EFFC.42ACE59E@us.ibm.com>
Date: Wed, 10 Oct 2001 15:03:56 -1000
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
In-Reply-To: <Pine.GSO.4.21.0110101743140.21168-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Wed, 10 Oct 2001, Mingming cao wrote:
> 
> > Hi Linus, Alan and Al,
> >
> > I found that rmdir(2) could remove current working directory
> > successfully.  This happens when the given pathname points to current
> > working directory, not ".", but something else. For example, the current
> > working directory's absolute pathname.  I read the man page of
> > rmdir(2).  It says in this case EBUSY error should be returned.  I
> > suspected this is a bug and added a check in vfs_rmdir(). The following
> > patch is against 2.4.10 and has been verified.  Please comment and
> > apply.
> 
> It's not a bug.  Moreover, test you add is obviously bogus - what about
> cwd of other processes?
> 
> Actually, rmdir() on a busy directory _is_ OK.  Implementation is allowed
> to refuse doing that, but it's not required to.

I thought about the case when rmdir() on the cwd of other processes,
but, as you said, that is implementation dependent. However rmdir() on
"." does returns EBUSY error. Should not we keep the rmdir() behavior
consistent: rmdir() on the current working directory of the current
process is not OK?

-- 
Mingming Cao
