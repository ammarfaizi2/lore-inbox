Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSGAIKl>; Mon, 1 Jul 2002 04:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGAIKk>; Mon, 1 Jul 2002 04:10:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22533 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315457AbSGAIKk>;
	Mon, 1 Jul 2002 04:10:40 -0400
Message-ID: <3D20104C.BF156E78@zip.com.au>
Date: Mon, 01 Jul 2002 01:18:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, davej@suse.de
Subject: Re: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my files.
References: <3D200BF6.3A6D9B59@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> 2.5.24-dj1 gave me files with zeroed blocks inside.
> What I did:  I untarred the source for lyx 1.2.0
> and tried to compile it, several times.
> 
> gcc and make choked on occational blocks of zeroes
> inside files, different places each time.
> Going back to 2.5.18 fixed it.
> 
> This isn't all that surprising considering that
> the raid driver logs complaints about requests
> bigger than 32k, which is the stripe size.
> I believed this worked by retrying with much smaller
> requests, perhaps I am wrong?
> 
> The filesystems use 4k blocks.
> I haven't seen any trouble on non-raid or raid-1
> partitions.

Yes, the large BIO stuff went into 2.5.19.  RAID0 doesn't
like those big BIOs.  Jens is cooking up a fix for that.

Just to confirm that this is the problem, could you please
set MPAGE_BIO_MAX_SIZE in 32768 in fs/mpage.c and see if the
failure goes away?

-
