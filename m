Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbTHUJAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHUJAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:00:25 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:65436 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262527AbTHUJAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:00:24 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16196.35366.563218.572370@laputa.namesys.com>
Date: Thu, 21 Aug 2003 13:00:22 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
In-Reply-To: <20030820125301.3a1ed0fb.akpm@osdl.org>
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>
	<20030820125301.3a1ed0fb.akpm@osdl.org>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
 > >
 > > This has been brought up by Ulrich more than 3 years ago:
 > > http://marc.theaimsgroup.com/?l=linux-kernel&m=95569775802945&w=2
 > 
 > A decent fallocate() implementation requires that the underlying fs has a
 > permanent representation of blocks which are in an "allocated,
 > uninitialised" state.  afaik XFS is the only such filesystem.
 > 
 > It's a fair bit of work for what doesn't really sound a very useful
 > feature.  Doing it in libc is reasonable.  Probably the libc implementation
 > could be improved by using ioctl(FIBMAP) and O_DIRECT to mimimise IO and
 > CPU utilisation.

fallocate() will be useful when writing into file through
mmap(). Currently kernel can just drop dirtied page at any moment (if
->writepage() fails with -ENOSPC), so the only safe way to modify file
through mmap() is by using mlock().

 > 
 > > Is there anytime soon that kernel 2.6 will have such functionality?
 > 
 > Nope.
 > 

Nikita.

