Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277544AbRJOPCc>; Mon, 15 Oct 2001 11:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277545AbRJOPCW>; Mon, 15 Oct 2001 11:02:22 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:62223 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277544AbRJOPCH>; Mon, 15 Oct 2001 11:02:07 -0400
Date: Mon, 15 Oct 2001 17:02:39 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: proc file system
Message-ID: <20011015170239.G2542@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20011010190442.A26980@artax.karlin.mff.cuni.cz> <Pine.LNX.4.21.0110142051320.6433-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110142051320.6433-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Sun, Oct 14, 2001 at 09:06:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Well, to get tail -f to work, minimally you'll have to support
> >> ...
> 
> > ... thus it won't work on char dev at all;-)
> 
> Why won't it?

Well, I didn't look thoroughly, so it might. But - it uses stat and
stat stats the device inode, not the device itself.

> > (but simple cat will do lot better).

But you really don't care about tail -f neither with device, nor with
/proc file. Because you can do cat and block the reads in kernel.

> How about the aspects of /proc files that are outside of your driver's
> control...
> 
>  1. The actual size of the /proc file is controlled by a variable that
>     your driver sets. Your driver gets no indication whatsoever as to
>     when that variable is read.

AFAICS (from source), neither can you with character device. You can't
set size for character device at all.

>  2. Your driver is required to recreate the ENTIRE /proc file every
>     time a read() call is made, and gets NO indication as to which
>     part of the file is actually returned to the caller.

AFAIK You have a control of both file and inode operations for proc file.  It's
your inode and you can set whatever you want there. On the other hand with
device you can only set file_operations (you can't touch the inode structure or
you might confuse the fs driver).

Just there are default proc file and inode operations that are used for
most purposes (there is the /proc/kcore, which is like /dev/kmem - they
work simlarly (neither can create it's content to a buffer), but only
/proc/kcore has meaningful size.

> Compare these to the requirements of a character device...
> 
>  1. There is no actual size stored anywhere - and, as a matter of fact,
>     the whole concept of file size is meaningless.

That's why you can't get tail -f (nor tail) work on a device.

>  2. When your driver gets a read() call, it is only required to return
>     data that has never before been returned, and not data that has
>     been previously read. Indeed, it is an error to return the same
>     data twice.

AFAIK, that's possible with /proc file too.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
