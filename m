Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268418AbRGXSIw>; Tue, 24 Jul 2001 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRGXSIm>; Tue, 24 Jul 2001 14:08:42 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:60624 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S268419AbRGXSI3>; Tue, 24 Jul 2001 14:08:29 -0400
Message-Id: <5.1.0.14.2.20010724185730.00b1fec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 24 Jul 2001 19:07:47 +0100
To: Davide Libenzi <davidel@xmailserver.org>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: user-mode port 0.44-2.4.7
Cc: Alexander Viro <viro@math.psu.edu>, Jonathan Lundell <jlundell@pobox.com>,
        Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <XFMail.20010724095229.davidel@xmailserver.org>
In-Reply-To: <Pine.GSO.4.21.0107241203260.25475-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 17:52 24/07/2001, Davide Libenzi wrote:
>On 24-Jul-2001 Alexander Viro wrote:
> > On Tue, 24 Jul 2001, Davide Libenzi wrote:
>You're simply telling the compiler the way it has to ( not ) optimize the 
>code.
>This is IMHO a declaration time issue.
>Looking at this code :
>
>while (jiffies < ...) {
>         ...
>}
>
>the "natural" behaviour that a reader expects is that the "content" of the 
>memory pointed by  jiffied  is loaded and compared.

Well, that depends on your definition of "natural". In my definition, it 
would be absolutely normal in this example for the compiler to cache 
jiffies because it considers it as a non-changing variable if none of the 
code inside the while loop refers to jiffies again. But that's just me...

>If you like this code more :
>
>for (;;) {
>         barrier();
>         if (jiffies >= ...)
>                 break;
>         ...
>}

Er, what is wrong with:

while (barrier(), jiffies < ...) {
         ...
}

It is just as clean as the starting point but tells both the compiler at 
compile time and _me_ when reading the code that jiffies is expected to 
change under me.

That is _way_ better than declaring it volatile in some obsure header file 
which, chances are, I have never looked at, or looked at and long forgotten 
about...

Just my 2p.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

