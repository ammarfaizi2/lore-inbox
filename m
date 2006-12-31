Return-Path: <linux-kernel-owner+w=401wt.eu-S933187AbWLaPCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbWLaPCf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 10:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbWLaPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 10:02:35 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38008 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183AbWLaPCe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 10:02:34 -0500
Date: Sun, 31 Dec 2006 16:02:33 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <20061220195458.GH17561@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612311550200.15327@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0612201732040.6115@artax.karlin.mff.cuni.cz>
 <E1Gx4dv-00058S-00@dorka.pomaz.szeredi.hu> <20061220195458.GH17561@ftp.linux.org.uk>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006, Al Viro wrote:

> On Wed, Dec 20, 2006 at 05:50:11PM +0100, Miklos Szeredi wrote:
>> I don't see any problems with changing struct kstat.  There would be
>> reservations against changing inode.i_ino though.
>>
>> So filesystems that have 64bit inodes will need a specialized
>> getattr() method instead of generic_fillattr().
>
> And they are already free to do so.  And no, struct kstat doesn't need
> to be changed - it has u64 ino already.

If I return 64-bit values as ino_t, 32-bit programs will get EOVERFLOW on 
stat attempt (even if they are not going to use st_ino in any way) --- I 
know that POSIX specifies it, but the question is if it is useful.

What is the correct solution? Mount option that can differentiate between 
32-bit colliding inode numbers and 64-bit non-colliding inode numbers? Or 
is there any better idea.

Given the fact that glibc compiles anything by default with 32-bit ino_t, 
I wonder if returning 64-bit inode number is possible at all.

Mikulas
