Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263380AbSJFLOn>; Sun, 6 Oct 2002 07:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbSJFLOn>; Sun, 6 Oct 2002 07:14:43 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:38668 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263380AbSJFLOm>; Sun, 6 Oct 2002 07:14:42 -0400
Message-ID: <3DA01C81.D2BDD8C7@aitel.hist.no>
Date: Sun, 06 Oct 2002 13:20:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Re: 2.5.40: raid0_make_request bug and bad: scheduling while atomic!
References: <anf7nq$qp2$1@ncc1701.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> I'm trying to test 2.5.40 on a NNTP peering server that pumps
> hundreds of gigs per day over the network. Interested to see
> if I can increase that with 2.5 ;)
> 
> Unfortunately my history databases etc are on RAID0:
> 
> raid0_make_request bug: can't convert block across chunks or bigger than 32k 8682080 24
> raid0_make_request bug: can't convert block across chunks or bigger than 32k 8679792 24
> 
> This appears to be a known problem, but I couldn't find a pointer
> to a solution anywhere. Scared, I ran fsck -f /dev/md0,
> saw no errors, and booted back to 2.4.19

The workaround is to force BIO's to be no bigger than a page.
That limits performance, but it should still be somewhat better
than the pre-bio times.

This used to be fixable in mpage.c, where a comment
explained what to to in precense of "braindead drivers"
But mpage.c changed sometime between 2.5.36 and 2.5.39.

Now the new include/linux/bio.h has the following:
#define BIO_MAX_PAGES           (256)
I tried substituting (1) for (256), but it didn't help.
So I don't mount raid-0 right now.

Helge Hafting
