Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129583AbRCPCp4>; Thu, 15 Mar 2001 21:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCPCpg>; Thu, 15 Mar 2001 21:45:36 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44427 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129583AbRCPCpc>;
	Thu, 15 Mar 2001 21:45:32 -0500
Date: Thu, 15 Mar 2001 21:44:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David <david@blue-labs.org>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
In-Reply-To: <3AB17547.9020507@blue-labs.org>
Message-ID: <Pine.GSO.4.21.0103152131230.10709-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Mar 2001, David wrote:

> 2.4.2-ac4
> 
> Mar 15 18:02:49 Huntington-Beach kernel: end_request: I/O error, dev 
> 16:41 (hdd), sector 9512
> Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for command
> Mar 15 18:02:48 Huntington-Beach kernel: hdd: drive not ready for command
> Mar 15 18:02:49 Huntington-Beach kernel: hdd: status error: status=0x00 { }
> Mar 15 18:02:49 Huntington-Beach kernel: hdd: drive not ready for command
> Mar 15 18:02:49 Huntington-Beach kernel: journal-601, buffer write failed
> Mar 15 18:02:49 Huntington-Beach kernel: kernel BUG at prints.c:332!

Umm... Chris, I really don't think that panic() (or BUG(), for that matter)
is an appropriate reaction to IO errors. They are expected events, after
all...

ObReiserfs_panic: what the hell is that ->s_lock bit about? panic() _never_
tries to do any block IO. It looks like a rudiment of something that hadn't
been there for 5 years, if not longer. The same goes for ext2_panic() and
ufs_panic(), BTW... I would suggest crapectomey here.
							Cheers,
								Al

