Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281286AbRKPKsA>; Fri, 16 Nov 2001 05:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281289AbRKPKrk>; Fri, 16 Nov 2001 05:47:40 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19205 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S281286AbRKPKrc>; Fri, 16 Nov 2001 05:47:32 -0500
Date: Fri, 16 Nov 2001 11:47:28 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: synchronous mounts
Message-ID: <20011116114728.J5520@emma1.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com> <3BF45B9F.DEE1076B@mandrakesoft.com> <3BF4CF5C.18CBE4BC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BF4CF5C.18CBE4BC@zip.com.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001, Andrew Morton wrote:

> A `dirsync' option does make sense though, for the reasons which
> Stephen outlined.

So we could then have:

- (no option) == async, which only syncs file + data on fsync() or
   O_SYNC (BSD calls this async, it may corrupt file systems because
   writes are out-of-order)
- dirsync, which syncs directories and metadata and causes ordered
  writes thereof (BSD calls this noasync), no chance of corrupting
  on-disk structure unrecoverably.
- sync, which syncs all filesystem operations (BSD calls this sync
  also), will have at most 1 dirty block at a time on non-journaled file
  systems(?)

I expect sync to be faster on journalled file systems in that case,
because "in-order execution" to journal will probably cause linear
writes, while on ext2, it will involve seeking.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
