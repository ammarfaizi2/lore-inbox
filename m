Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbTGJUtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbTGJUtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:49:45 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:48312 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S266405AbTGJUto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:49:44 -0400
Message-ID: <3F0DD3FD.3030403@triphoenix.de>
Date: Thu, 10 Jul 2003 23:00:45 +0200
From: Dennis Bliefernicht <itsme.nospam@triphoenix.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
References: <7QmZ.5RP.17@gated-at.bofh.it>
In-Reply-To: <7QmZ.5RP.17@gated-at.bofh.it>
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On the other hand, what if on rare occasions the pointer actually is NULL,
> even though it's not supposed to be?  This can only be the result of an
> error somewhere else in the kernel (such as incorrect locking during a
> data structure update).  Detecting the NULL pointer and returning an error
> code will hide the existence of the true underlying error.  But if the
> check _isn't_ made, then as soon as the pointer is derefenced there will
> be a nice big segfault.  This will immediately alert people to the
> existence of a problem, something they otherwise might not be aware of at
> all.
The problem is IMHO code where some pretty fragile things are handled, 
especially file systems. I'd say: DO the paranoia checks if some fragile 
things are involved like key structures of the file system that can take 
_permanent_ damage. If you check for a NULL pointer you still have the 
chance to properly leave the system in a consistent state and no user 
will be happy if his filesystem goes messy just because someone saved a 
check to have nicer code, even if the original of the NULL pointer 
wasn't his fault, even if it's a developing version. So if the check 
isn't a total performace disaster, do it whenever permanent damage could 
occur.
On other sections where, let's say just a user memory allocation would 
crash, checks could be ommitted, because it isn't that fatal and leaves 
no permanent destruction.

Just my opinion :)
TriPhoenix

