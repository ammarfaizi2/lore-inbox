Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319243AbSIFQBu>; Fri, 6 Sep 2002 12:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319244AbSIFQBu>; Fri, 6 Sep 2002 12:01:50 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:20611 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S319243AbSIFQBt>; Fri, 6 Sep 2002 12:01:49 -0400
Date: Fri, 6 Sep 2002 17:06:14 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented) files
Message-ID: <20020906170614.A7946@redhat.com>
References: <20020903092419.GA5643@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020903092419.GA5643@vitelus.com>; from aaronl@vitelus.com on Tue, Sep 03, 2002 at 02:24:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 03, 2002 at 02:24:19AM -0700, Aaron Lehmann wrote:

> [aaronl@vitelus:~]$ time cat mail/debian-legal > /dev/null
> cat mail/debian-legal > /dev/null  0.00s user 0.02s system 0% cpu 5.565 total
> [aaronl@vitelus:~]$ ls -l mail/debian-legal
> -rw-------    1 aaronl   mail      7893525 Sep  3 00:42 mail/debian-legal
> [aaronl@vitelus:~]$ time cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null
> cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null  0.00s user 0.10s system 16% cpu 0.616 total
> [aaronl@vitelus:~]$ ls -l /usr/src/linux-2.4.18.tar.bz2 
> -rw-r--r--    1 aaronl   aaronl   24161675 Apr 14 11:53
> 
> Both files were AFAIK not in any cache, and they are on the same
> partition.
> 
> My current uninformed theory is that this is caused by fragmentation,
> since the linux tarball was downloaded all at once but the mailbox I'm
> comparing it to has 1695 messages, each of which having been appended
> seperately to the file. All of my mailboxes exhibit similarly awful
> performance.

Yep, both ext2 and ext3 can get badly fragmented by files which are
closed, reopened and appended to frequently like that.

> Do any other filesystems handle this type of thing more gracefully?

There are some ideas from recent FFS changes.  One thing they now do
is to defragment things automatically as a file grows by effectively
deleting and then reallocating the last 16 blocks of the file.
Fragmentation will still occur, but less so, if we do that.

Cheers,
 Stephen
