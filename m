Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUADCKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUADCKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:10:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:65217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264903AbUADCKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:10:05 -0500
Date: Sat, 3 Jan 2004 18:09:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040104000840.A3625@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
References: <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net>
 <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl>
 <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
 <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
 <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
 <20040104000840.A3625@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Andries Brouwer wrote:
> 
> Empty talk. This is not about finding and fixing bugs.
> We know very precisely what properties the NFS protocol has.
> Now one can have a system that works as well as possible with NFS.
> And one can have a worse system.

Oh, things can be _much_ worse than /dev over NFS. 

You don't seem to realize what I men with "not enumerable".

With NFS, you could have some strange per-mount device number mapping etc, 
and it wouldn't need to be all that complicated.

But if you start considering network-attached storage (as in "disks over
IP", not as in "samba"), the problem is that you fundamentally cannot
enumerate the things on a kernel level. EVER. There is no way to do
automatic discovery, because the bus fundamentally isn't enumerable. It
isn't even _repeatable_, ie if you do broadcast "tell me what disks
exists", the results won't be ordered some way.

In other words, the device numbers that eventually get attached to these 
disks (however the discovery ends up working - with the sysadmin 
explicitly mentioning them, or with some kind of broadcast protocol) 
simply WILL NOT NECESSARILY be the same across reboots. 

And there just _isn't_ any way to make them the same or to "describe" the 
storage in any integer of any finite length. It has nothing to do with 
32-bit vs 64-bit vs 1024-bit.

Once you accept that fact, you should accept the fact that device numbers 
not only have no meaning, they literally have no permanence across reboots 
either.

Yes, the common case is permanent. What I'm saying is that the common case 
_cannot_ be the generic case. 

		Linus
