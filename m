Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269971AbRIAClR>; Fri, 31 Aug 2001 22:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRIAClI>; Fri, 31 Aug 2001 22:41:08 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:24083 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S269971AbRIAClA>; Fri, 31 Aug 2001 22:41:00 -0400
Message-ID: <3B904AC4.6A449086@zip.com.au>
Date: Fri, 31 Aug 2001 19:41:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mb/ext3@dcs.qmul.ac.uk
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 oops under moderate load
In-Reply-To: <Pine.LNX.4.33.0108301740420.7921-100000@inconnu.isu.edu> <Pine.LNX.4.33.0108310759460.13139-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mb/ext3@dcs.qmul.ac.uk wrote:
> 
> Hi bug hunters,
> 
> I left my spangly new dual PIII with an ext3 partition on a Promise
> FastTrak 100TX2 being used both by a local process and knfsd for a few
> hours, and the following happened:
> 
> [ 2.4.9-ac3 SMP (noapic) + the one patch from Zygo Blaxell to recognise
> the Promise card; now I have kupdated, kjournald and user-space processes
> trying to access the volume in question all in state 'D' ]
> 
> kernel BUG at revoke.c:307!

Yours is the third report of this - it's definitely a bug in
ext3.  I still need to work out how you managed to get a page
attached to the inode which has not had its buffers fed through
journal_dirty_data().  There seem to be several ways in which
this can happen.

Is it possible that you ran out of disk space on the relevant
partition shortly before it died?

-
