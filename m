Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVJIVpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVJIVpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJIVpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:45:19 -0400
Received: from [67.137.28.189] ([67.137.28.189]:26752 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S932292AbVJIVpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:45:17 -0400
Message-ID: <43497B09.3020102@utah-nac.org>
Date: Sun, 09 Oct 2005 14:18:17 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan> <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org> <43497533.6090106@utah-nac.org> <20051009212916.GM7992@ftp.linux.org.uk>
In-Reply-To: <20051009212916.GM7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Sun, Oct 09, 2005 at 01:53:23PM -0600, jmerkey wrote:
>  
>
>>Someone needs to fix fsck.ext3 while they are at it so it doesn't barf 
>>when reading from reisferfs filesystems and return a command return of > 
>>2 during scanning of parttions during bootup. This looks like some sort 
>>of anti-competitive crap and it doesn't belong in fsck.ext3 since 
>>reiserfs is in the kernel.
>>    
>>
>
>Huh?  WTF are you trying to feed reiserfs to fsck.ext3 and just what do
>you expect it to do?
>
>  
>
If they all use the same on disk formats as their basic structure, fsck 
should not return gt > 1 due to misinterpreting reiser on-disk 
structures. It should say "oh not one of mine, skipping". Instead it 
returns an error claiming massive corruption, and halts the system. I 
just upgraded my wifes computer from Suse to RedHat FC4 and when it hits 
the reiser partitions, the whole system explodes due to fsck.ext3 
misrecognizing reiser partitions. I had to modify rc.sysinit and blank 
the partitions with fdisk to get it to install. After it installed, I 
recreated the partitions (after writing down what they were in the first 
place for block #'s etc.) and disabled rc.sysinit checks. This is 
busted. Hans needs to fix fsck.ext3 and submit a patch or redhat does.

J


