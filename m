Return-Path: <linux-kernel-owner+w=401wt.eu-S1030231AbXAHWEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbXAHWEy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbXAHWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:04:53 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:48537 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030186AbXAHWEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:04:52 -0500
Date: Mon, 8 Jan 2007 22:53:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Erez Zadok <ezk@cs.sunysb.edu>
cc: Andrew Morton <akpm@osdl.org>, "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation 
In-Reply-To: <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0701082245230.23737@yvahk01.tjqt.qr>
References: <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 15:51, Erez Zadok wrote:
>
>BTW, this is a problem with all stackable file systems, including
>ecryptfs. To be fair, our Unionfs users have come up against this
>problem, usually for the first time they use Unionfs :-).  Then we
>tell not to do that, but that if they have to, to run "uniondbg -g"
>afterward to force a flushing of Unionfs caches.  This practical
>suggestion worked well for our Unionfs users so far.

Speaking of practicality, would not it be easiest to add a mount-time
option that says "don't ever cache"? Or perhaps "enable cache, I
assure you I don't fiddle with the lower layer".

>Another possibility is that after, hopefully, both Unionfs and
>ecryptfs are in, and some more user experience has been accumulated,
>that we'll look into addressing this page-cache consistency problem
>for all stacked f/s.

Not that I know much about memory handling, but...:

When a process writes to a file, the write is cached by default. If
now an origin tag (as in: a struct member) is attached to this cached
object, unionfs/VFS can decide whether the last write access has
happened from within unionfs or something else, and act accordingly,
namely (1) flush when origin tag is not "unionfs" (2) do as usual
like today's unionfs. Think of it like a "last changed by"-attribute.


	-`J'
-- 
