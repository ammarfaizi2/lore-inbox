Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277823AbRJIQup>; Tue, 9 Oct 2001 12:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277822AbRJIQum>; Tue, 9 Oct 2001 12:50:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:17637 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277828AbRJIQuW>; Tue, 9 Oct 2001 12:50:22 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: Richard Henderson <rth@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF5A7A240A.5E819030-ON88256AE0.00550151@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 08:28:40 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 10:50:47 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Oct 08, 2001 at 10:56:10PM -0700, David S. Miller wrote:
> > I somehow doubt that you need an IPI to implement the equivalent of
> > "membar #StoreStore" on Alpha.  Richard?
>
> Lol.  Of course not.  Is someone under the impression that AXP
> designers were smoking crack?

The ones I have talked to showed no signs of having done so.  However,
their architecture -does- make it quite challenging for anyone trying to
write lock-free common code, hence all the IPIs.

> "wmb" == "membar #StoreStore".
> "mb"  == "membar #Sync".
>
> See the nice mb/rmb/wmb macros in <asm/system.h>.

OK, if "membar #StoreStore" really is equivalent to "wmb", then
"membar #StoreStore" definitely will -not- do the job required here.
Will "membar #SYNC" allow read-side "membar #ReadRead"s to be omitted,
or does "membar #SYNC" fail to detect when outstanding cache
invalidations complete?

                              Thanx, Paul

