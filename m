Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269685AbSISWKo>; Thu, 19 Sep 2002 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271500AbSISWKo>; Thu, 19 Sep 2002 18:10:44 -0400
Received: from packet.digeo.com ([12.110.80.53]:37798 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269685AbSISWKn>;
	Thu, 19 Sep 2002 18:10:43 -0400
Message-ID: <3D8A4C8A.D8DED29A@digeo.com>
Date: Thu, 19 Sep 2002 15:15:38 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Mingming Cao <mcao@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
       suparna@linux.ibm.com, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
References: <3D8A4352.862A0B1A@digeo.com> from "Andrew Morton" at Sep 19, 2002 01:36:18 PM PST <200209192153.g8JLrNV23057@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 22:15:38.0594 (UTC) FILETIME=[15884420:01C2602A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> ...
> > The other thing we've lost is the BIO-pruning and recycling effect: the
> > current direct-io code will reap BIOs while it is actually submitting
> > them, so the peak consumption is kept under control.  Plus there are
> > cache-warmness issues.  But without having a process there to do all this,
> > we obviously have to lose some things.
> >
> 
> I don't follow you. In original code, we only reap the BIO's on which IO
> is complete. How is it controlling peak consumption ?

Ah.  The current direct-io code will, while submitting those BIOs,
occasionally go and see if any have completed already.  If they have
then they are processed and returned to the global BIO pool.

But you're returning them from within end_io, so no prob.
