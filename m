Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSDEHqK>; Fri, 5 Apr 2002 02:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312354AbSDEHqA>; Fri, 5 Apr 2002 02:46:00 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:49938 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S312261AbSDEHp4>; Fri, 5 Apr 2002 02:45:56 -0500
Date: Thu, 4 Apr 2002 23:45:55 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <akpm@zip.com.au>
cc: <joeja@mindspring.com>, <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <3CACEF18.CE742314@zip.com.au>
Message-ID: <Pine.LNX.4.33.0204042330270.10358-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Andrew Morton wrote:

> I guess the greatest benefit would come from reorganising the
> layout of the root filesystem's data and metadata so the
> pagecache prepopulation doesn't have to seek all over the place.

windows xp does this automatically (but it takes a lot of idle time before
it'll start playing with your disk)... search for "bootvis" at
microsoft.com, that tool can force the reorganization to occur.  it's
worth 10%ish there as well (quite noticeable on laptops).  they appear to
reorganize the boot-time files into one big contiguous region.  that's
fetched into their equivalent of the page cache with sequential reads.

it's certainly interesting theory -- trying to do disk layout which is
optimised for particular access patterns... it's kind of a hack to do this
just for boot time, but definitely educational :)

in some ways, the filesystem is the wrong place to do this type of
activity -- you could approach the problem as a block layer device between
the fs and the hardware which maintains statistics on access patterns and
moves blocks around to optimise access time -- which lets you fix all
sorts of seeking problems.  i guess the challenge would be maintaining a
map of logical block number to physical block number.  hmm.  guess that's
kind of hard.

-dean

