Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUCKTlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbUCKTlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:41:20 -0500
Received: from d216-232-223-137.bchsia.telus.net ([216.232.223.137]:29356 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id S261669AbUCKTlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:41:12 -0500
To: Jesse Pollard <jesse@cats-chateau.net>
cc: linux-kernel@vger.kernel.org, =?iso-8859-1?q?S=F8renHansen?= <sh@warma.dk>
Subject: Re: UID/GID mapping system
From: Kevin Buhr <buhr@telus.net>
References: <04031108083100.05054@tabby> <1078775149.23059.25.camel@luke>
 <04031015412900.03270@tabby> <20040310234640.GO1144@schnapps.adilger.int>
Date: Thu, 11 Mar 2004 11:40:41 -0800
In-Reply-To: <fa.ct61k6d.bm43gj@ifi.uio.no> (Jesse Pollard's message of
 "Thu, 11 Mar 2004 14:10:47 GMT")
Message-ID: <873c8f18au.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> writes:
>
> Absolutely true. The attacker can do the "su" to any uid. Which is
> why the server must be the one to provide the mapping service. The
> server does not have to accept the UID unless it is one of the
> entries in the authorized map.

Here's a simple, typical problem:

I want to connect a Linux laptop to a network with existing NFS/NIS
infrastructure in place and mount and use, say, an NFS home directory.
Unfortunately, the UID mappings differ between the existing
infrastructure and my laptop.  For example, all the files in my NFS
directory are all owned by uid=45067 gid=102, but my user and default
group on the laptop are 1000 and 1000 respectively.

I don't adminsiter the NFS server; I can't ask the administrator to
set up a server-side mapping system just for my benefit.  But, I *can*
convince the administrator to add:

/home/b/u/buhr mymachine(squash_uids=0-45066,45068-65535,squash_gids=0-100)

to his exports file.

Now, I can mount this filesystem on my machine.  Trouble is, I can't
read or write any of my files.

Now, I could edit my local "passwd" and "group" files, change the
ownership of the files in my local home directory, and everything
would work smashingly.  Or, I could use Søren's patch with a mapping
file and a mount option to achieve a similar effect with much less
work and disturbance.

Bottom line: Søren's patch would be very useful in a number of
real-world situations, and it can't *possibly* have an signficant
adverse effect on security because any attacker able to modify the
client-side mappings could, in principle, modify "passwd" and "group"
or write and install a similar kernel patch on the client anyway.

-- 
Kevin <buhr@telus.net>
