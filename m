Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJNQlY>; Sun, 14 Oct 2001 12:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJNQlE>; Sun, 14 Oct 2001 12:41:04 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:10187
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S274368AbRJNQk4>; Sun, 14 Oct 2001 12:40:56 -0400
Date: Sun, 14 Oct 2001 12:41:05 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Ed Tomlinson <tomlins@CAM.ORG>,
        Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        linux-kernel@vger.kernel.org
Subject: Re: mount hanging 2.4.12
Message-ID: <2169490000.1003077665@tiny>
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110141231570.6026-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, October 14, 2001 12:32:33 PM -0400 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Sun, 14 Oct 2001, Chris Mason wrote:
> 
>> 
>> 
>> On Sunday, October 14, 2001 11:55:20 AM -0400 Ed Tomlinson
>> <tomlins@CAM.ORG> wrote:
>> > 
>> > Chris, what I suspect is happening is that the mount with the error
>> > leaves the sem locked.  After this any mount commant hangs - not just
>> > ones for the USB card read (ie. loop mount to build an initrd fails
>> > too..)
>> 
>> Yup, I see the, I'll send a new patch a little later today.
> 
> Cc: it to me, OK?

Sure, I was holding off on a cc to linux-kernel because I really don't like
it though ;-)  This is the LVM locking patch, so before making a snapshot
LVM wants to flush the FS and block new transactions.

LVM does this:
lockfs(dev) ;
make snapshot
unlockfs(dev) ;

This can happen while dev is either mounted or unmounted.  If dev was
unmounted when the lockfs was called, I'd like to make sure nobody can
mount it before the unlockfs is done.  I did this with a new semaphore in
fs/super.c, but I'd rather find something cleaner...

-chris

