Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVERAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVERAf0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 20:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVERAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 20:35:26 -0400
Received: from lucidpixels.com ([66.45.37.187]:1920 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S262000AbVERAfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 20:35:15 -0400
Date: Tue, 17 May 2005 20:35:13 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducible 2.6.11.9 NFS Kernel Crashing Bug!
In-Reply-To: <1116341217.21388.145.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0505172034430.2028@localhost.localdomain>
References: <Pine.LNX.4.63.0505140911580.2342@localhost.localdomain>
 <1116341217.21388.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

It also fails with 8192, totally crashes the box!
Seconds after (3-8 seconds), the remote host is dead, even with 8192.

I get an IRQ #18, Nobody Cared!
Has something with e1000x/and ata/x/something in the crash dump.
Disabling interrupt 18.

box:~# df -h | grep /x5
box:~# mount -a
box:~# df -h | grep /x5
p500:/d5/x5           234G   45G  189G  20% /p500/x5
box:~# grep /x5 /etc/fstab
#p500:/d5/x5      /p500/x5         nfs 
rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0
p500:/d5/x5      /p500/x5         nfs 
rw,hard,intr,rsize=8192,wsize=8192,nfsvers=3 0 0
box:~#
box:~# mount | grep x5
p500:/d5/x5 on /p500/x5 type nfs 
(rw,hard,intr,rsize=8192,wsize=8192,nfsvers=3,addr=192.168.0.253)
box:~# dd if=/dev/hde of=/p500/x5/file.img bs=1M

And Al,

This is going to sound absolutely crazy, but my box would *NOT* come back 
up after the dd.  It gets to the point where it initializes the network but the 
machine that did the dd must be sending some kind of NASTY packet that KILLS
the kernel, as soon as it initializes eth0 BAM, it freezes at the console when
it is trying to boot up.  The fix is to shut off the machine that did the 
dd or disconnect the network cable and then voila it comes back up.  Also, the 
machine that did the dd was SERIOUSLY lagged almost unusable.

Any ideas?

I'd prefer not to repeat this problem again, thanks!

Justin.



On Tue, 17 May 2005, Alan Cox wrote:

> On Sad, 2005-05-14 at 14:18, Justin Piszcz wrote:
>> The mount options I am using are:
>> rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0
>
> These are rather extreme r/wsizes especially if you are using UDP - I'm
> assuming this is TCP ?
>
>> Oh, and incase one may think there is a network issue, there is not,
>> during normal operation when I am not running dd, there are no network
>> problems, as shown below.
>
> I would certainly expect it to be a memory issue. Does it occur with
> 8192 as the size ?
>
