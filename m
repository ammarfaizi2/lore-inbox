Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283781AbRK3UMW>; Fri, 30 Nov 2001 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283779AbRK3UMD>; Fri, 30 Nov 2001 15:12:03 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17281 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S283766AbRK3ULn>; Fri, 30 Nov 2001 15:11:43 -0500
Message-Id: <200111302011.fAUKBZ408955@eng4.beaverton.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David C. Hansen" <haveblue@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions 
In-Reply-To: Your message of "Fri, 30 Nov 2001 04:57:28 EST."
             <Pine.GSO.4.21.0111300444180.13367-100000@weyl.math.psu.edu> 
Date: Fri, 30 Nov 2001 12:11:35 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you're exactly the right person to be helping out with this;
glad to see you join the discussion.

The biggest flaw in the patch was not realizing that chrdev_open held
the BKL for us during opens as well.  I don't think that invalidates it
in its entirety though.  In cases where the patch replaced BKL with
some other form of locking, we should be no worse off (but for your
concerns about scheduling) because we added it in the open routines
too.  In cases where we removed BKL from release but noted there were
"still" locking issues, yes, we need to examine those closely and fix
them in case we've created a locking issue where none existed before.

In most (all?) cases, the spinlocks are held briefly and (we believe)
not across scheduling opportunities.  If you see areas of the patch
where that is not true, I agree they should be addressed and please point
them out.

Rick
