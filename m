Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbRETLT3>; Sun, 20 May 2001 07:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRETLTK>; Sun, 20 May 2001 07:19:10 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S261842AbRETLSv>;
	Sun, 20 May 2001 07:18:51 -0400
Message-ID: <20010520131730.D10924@bug.ucw.cz>
Date: Sun, 20 May 2001 13:17:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: handling network using filesystem [was Re: no ioctls for serial ports?]
In-Reply-To: <20010519211717.A7961@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0105191958090.7162-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.GSO.4.21.0105191958090.7162-100000@weyl.math.psu.edu>; from Alexander Viro on Sat, May 19, 2001 at 08:01:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I thought about how to do networking without sockets, and it seems to
> > me like this kind of modify syscall is needed, because network sockets
> > connect to *two* different places (one local address and one
> > remote). Sockets are really nasty :-(.
> 
> Pavel, take a look at http://plan9.bell-labs.com/sys/man/3/ip

Looks nice, and it seems they are even able to run BSD socket
emulation over that. Wow.

However, it is still mid-ugly:

       Opening  the  clone  file reserves a connection.  The file
       descriptor returned from the open(2)  will  point  to  the
       control  file,  ctl,  of  the  newly allocated connection.
       Reading ctl returns a text string representing the  number
       of the connection.  Connections may be used either to lis­
       ten for incoming calls  or  to  initiate  calls  to  other
       machines.

So, you open "clone". That creates directory for you. You can get its
number by reading from "clone" file.

That's pretty strange, agreed?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
