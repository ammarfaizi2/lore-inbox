Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276777AbSIVG2B>; Sun, 22 Sep 2002 02:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276786AbSIVG2B>; Sun, 22 Sep 2002 02:28:01 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:5096 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S276777AbSIVG2A>; Sun, 22 Sep 2002 02:28:00 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: Serial port monitoring with keyboard LEDs
Date: Sun, 22 Sep 2002 16:26:26 +1000
User-Agent: KMail/1.4.5
References: <200209212106.g8LL6FKP001764@darkstar.example.net>
In-Reply-To: <200209212106.g8LL6FKP001764@darkstar.example.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209221626.26623.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 22 Sep 2002 07:06, jbradford@dial.pipex.com wrote:
> I'm using a 2.4.19 kernel as a reference, and looking at putting my code in
> /drivers/char/serial.c, specifically at the serial_in and serial_out
> functions, is this the Right Thing or not?  Obviously the LEDs won't
> actually reflect what is going out on the serial line, because of
> buffering, etc, and also, what's going to be more useful - just flash on
> and off for each byte sent, or LED on for 1, LED off for 0 bit?  That would
> be even more of an approximation to what's actually happening on the serial
> line, because obviously we're sending a byte at a time to the serial port.
Not sure about the serial code. 

However you can't update the keyboard LEDs at anything like normal serial port 
rates. And even if you could update at 10kHz, you just varied the brightness, 
rather than caused any real "blinking"

> Any pointers to docs I should read would be appreicated :-)
You are going to cause problems. There are other users of keyboard LEDs in the 
kernel (eg for notifying of an oops). It isn't looking too good.

If you are really intent on doing this, you can probably manage this from 
userspace, using the event interface and the application that is sending data 
over the serial interface. Of course, you'd need to have a suitable keyboard 
(probably only USB or ADB in 2.4.x).

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9jWKSW6pHgIdAuOMRAs6lAJ9w0Rn9N31TNrb6+jk2a3kwTA9RZQCeLV40
bDEJ/o3W5w53efj9lIIwRys=
=t+NX
-----END PGP SIGNATURE-----

