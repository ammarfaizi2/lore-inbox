Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269292AbRGaNmw>; Tue, 31 Jul 2001 09:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269296AbRGaNmn>; Tue, 31 Jul 2001 09:42:43 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:9233 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S269292AbRGaNmk>; Tue, 31 Jul 2001 09:42:40 -0400
Date: Tue, 31 Jul 2001 09:41:25 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>, Chris Wedgwood <cw@f00f.org>
cc: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <687650000.996586885@tiny>
In-Reply-To: <3B668FA2.5E76BE1E@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tuesday, July 31, 2001 02:59:46 PM +0400 Hans Reiser <reiser@namesys.com>
wrote:

[ CONFIG_REISERFS_CHECK ]

> Last I ran benchmarks the performance cost was 30-40%, but this was some
> time ago.  I think that the coders have been quietly culling some checks
> out of the FS, and so it does not cost as much anymore.  I would prefer
> that the "excesive" checks had stayed in.
> 
> Sigh, I see I cannot persuade in this argument.  It seems Linus is right,
> and debugging checks don't belong in debugged code even if they would make
> it easier for persons hacking on the code to debug their latest hacks.
> 

In the end, the distributions are responsible for their own quality control,
and they are free to turn on whatever debugging features they like.  You can
yell, scream, call them names, and in general piss them off however you like
and they will still be absolutely correct in turning on whatever debugging
check they feel is important.

The right way to deal with this is ask why they think it's important to turn
on the checks.  The goal behind code under CONFIG_REISERFS_CHECK is to add
extra runtime consistency checks, but without CONFIG_REISERFS_CHECK on, the
code should still make sure it isn't hosing the disk.  In other words, the
goal is like this:

if (some_error) {
#ifdef CONFIG_REISERFS_CHECK
    panic("some_error") ;
#else
    gracefully_recover
#endif

There are places CONFIG_REISERFS_CHECK does extra scanning of the metadata
and such, but all of these are supposed to be things that can be recovered
from with the debugging off.  Anything else is a bug.

-chris

