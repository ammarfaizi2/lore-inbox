Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVBHXgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVBHXgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVBHXgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:36:10 -0500
Received: from hera.kernel.org ([209.128.68.125]:30898 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261692AbVBHXfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:35:03 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 3TB disk hassles
Date: Tue, 8 Feb 2005 23:33:51 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cubi8v$3mg$1@terminus.zytor.com>
References: <20050206105958.42872.qmail@web26501.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1107905631 3793 127.0.0.1 (8 Feb 2005 23:33:51 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 8 Feb 2005 23:33:51 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050206105958.42872.qmail@web26501.mail.ukl.yahoo.com>
By author:    Neil Conway <nconway_kernel@yahoo.co.uk>
In newsgroup: linux.dev.kernel
> 
> Since writing the above, I've been searching for more info.  I
> downloaded four different versions of grub (GNU Grub Legacy, GNU Grub2,
> gentoo and Fedora Core 3).  NONE of these showed any evidence of GPT
> support (I was in a hurry, so I searched for strings EFI, GUID, GPT,
> TB).
> 
> Mucho confused puppy here.
> 
> I fail to see how grub can work on a GPT boot device if it can't parse
> the partition table.  I conclude that I'm still missing something. 
> Perhaps a layer before grub is supposed to parse the GPT instead?  If
> so, isn't that getting us straight back to a GPT-aware BIOS?
> 
> Tell me if this logic is broken: even if a special boot sector is used,
> which IS GPT-aware (though fitting that into the boot sector would be a
> challenge ;-)), once grub loads, it's still going to have to figure out
> how to find the root(hdX,Y) partition from which to load the kernel
> image.  This surely means it has to have either a GPT-parser
> internally, or rely on a pre-parsed list.  No?
> 
> Perhaps one of the other several distros (that I didn't check) has a
> GPT-aware grub.  But Tomas Carnecky said early in this thread that
> gentoo had allowed him to set up a GPT-booting system on x86.  I guess
> it's possible that a cheat was used - maybe an old-style partition
> table in the MBR was used to define the first (boot) partition, but
> surely that's forbidden by the whole EFI spec anyway?
> 

No, it's encouraged.

> 
> Andries Brouwer kindly wrote a patch which I haven't had time to test
> yet (see earlier in thread).  While it would be nice to find a way
> around the problem which didn't require deviations from vanilla
> distros, I think Andries' patch is looking like the only sane fix right
> now.
> 

Note that Andries' patch does *EXACTLY* the same thing as the GPT/EFI
spec does (by using an old-style partition table for the first 2 TB.)

It should be pretty easy to add native support for this in EXTLINUX;
the big problem is supporting true access > 2 TB, which I currently
don't have any way to test.

I'll put that on my todo list.

	-hpa
