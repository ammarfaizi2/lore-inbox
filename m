Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWIEWVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWIEWVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 18:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWIEWVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 18:21:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965214AbWIEWVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 18:21:15 -0400
Message-ID: <44FDF83A.8010707@sandeen.net>
Date: Tue, 05 Sep 2006 17:20:42 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Vasily Averin <vvs@sw.ru>
CC: Theodore Tso <tytso@mit.edu>, Stephen Tweedie <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, devel@openvz.org
Subject: Re: [PATCH] ext3: wrong error behavior
References: <44F96DD0.30608@sw.ru>
In-Reply-To: <44F96DD0.30608@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin wrote:
> SWsoft Virtuozzo/OpenVZ Linux kernel team has discovered that ext3 error
> behavior was broken in linux kernels since 2.5.x versions by the following patch:
> 
> 2002/10/31 02:15:26-05:00 tytso@snap.thunk.org
> Default mount options from superblock for ext2/3 filesystems
> http://linux.bkbits.net:8080/linux-2.6/gnupatch@3dc0d88eKbV9ivV4ptRNM8fBuA3JBQ
> 
> In case ext3 file system is mounted with errors=continue (EXT3_ERRORS_CONTINUE)
> errors should be ignored when possible. However at present in case of any error
> kernel aborts journal and remounts filesystem to read-only. Such behavior was
> hit number of times and noted to differ from that of 2.4.x kernels.

I've also noticed this differing behavior,

http://marc.theaimsgroup.com/?l=linux-ext4&m=115376966821953&w=2

It passed w/o comment.  :)

Unless Ted had a specific reason for changing the behavior, 2.4 and 2.6 
should probably be brought into line.  Calling ext3_commit_super() 
before the panic may defeat (some of) the purpose of the panic option, 
though, which is to preserve as much state as possible at the time of 
the error for later analysis...

-Eric
