Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbSJVUNa>; Tue, 22 Oct 2002 16:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSJVUMh>; Tue, 22 Oct 2002 16:12:37 -0400
Received: from hqvsbh1.ms.com ([205.228.12.101]:17912 "EHLO hqvsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S264849AbSJVUMT>;
	Tue, 22 Oct 2002 16:12:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15797.45713.507200.869046@axolotl.ms.com>
Date: Tue, 22 Oct 2002 16:18:25 -0400 (EDT)
From: Hildo.Biersma@morganstanley.com
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Tim Hockin <thockin@sun.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
In-Reply-To: <200210221303.47488.pollard@admin.navo.hpc.mil>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
	<1035308740.31873.107.camel@irongate.swansea.linux.org.uk>
	<3DB58CBD.3030207@sun.com>
	<200210221303.47488.pollard@admin.navo.hpc.mil>
X-Mailer: VM 6.75 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jesse" == Jesse Pollard <pollard@admin.navo.hpc.mil> writes:

Jesse> On Tuesday 22 October 2002 12:37 pm, Tim Hockin wrote:
>> Alan Cox wrote:
>> > On Tue, 2002-10-22 at 18:26, Tim Hockin wrote:
>> >>Alan Cox wrote:
>> >>>Ok sanity check time. Why do you need qsort and bsearch for this kind of
>> >>>thing. Just how many groups do you plan to support ?
>> >>
>> >>Unlimited - we've tested with tens of thousands.
>> >
>> > Now how about the real world requirements ?
>> 
>> Those were real world requirements - we got the number 10,000 from our
>> product management, which (presumably) spoke with customers.  On the
>> hosting systems, it is really possible to have thousands of virtual sites.
>> 
>> Now, I don't much care if you want it to be a linear search, and I'll
>> revert it, if needed, but qsort() is already in in XFS specific code,
>> and bsearch is small.  It doesn't negatively impact any fast path, and
>> provides better behavior for the crazies that really want 10,000 groups.
>> 
>> Tim

Jesse> Does it actually work with NFS???? or any networked file
Jesse> system?  Most of them limit ngroups to 16 to 32, and cannot
Jesse> send any data if there is an overflow, since that overflow
Jesse> would replace all of the data you try to send/recieve...

Jesse> And I really doubt that anybody has 10000 unique groups (or
Jesse> even close to that) running under any system. The center I'm at
Jesse> has some of the largest UNIX systems ever made, and there are
Jesse> only about 600 unique groups over the entire center. The
Jesse> largest number of groups a user can be in is 32. And nobody
Jesse> even comes close.

  $ ypcat group | wc -l
  9527

  $ ypcat passwd | wc -l
  62076

Yes, we're insane :-)

OTOH, we use AFS and PTS groups, because Unix groups don't scale.  And
we would not use the ngroups mechanism in Linux even if it did,
because we need to inter-operate with Solaris.

Cheers, Hildo
