Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267995AbRG3VJr>; Mon, 30 Jul 2001 17:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267993AbRG3VJh>; Mon, 30 Jul 2001 17:09:37 -0400
Received: from out4.prserv.net ([32.97.166.34]:63739 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S267885AbRG3VJX>;
	Mon, 30 Jul 2001 17:09:23 -0400
MIME-Version: 1.0
Message-Id: <3B65CD09.000001.33392@be1.prserv.net>
Date: Mon, 30 Jul 2001 21:09:29 +0000 (CUT)
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_TF1BQL80000000000000"
From: isnkrnl@attglobal.net
To: linux-kernel@vger.kernel.org
Subject: Bizarre multithread open/close problem
X-Mailer: Web Mail v2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--------------Boundary-00=_TF1BQL80000000000000
Content-Type: Text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

I'm not sure if this is a bug or not but my
coworker has a wierd one.

He has 2 threads, main and helper.

main:
f=open(/dev/brcmrec) does some work and then 

spawns helper:

helper spins forever doing various ioctls, read
and writes on f which was opened in main. Every
time through it looks at a "amIDone" flag which is
set by main.  pthreads are the threads.

Then at some point main wants to end helper and
close f.  Main sets "amIDone" which tells helper
to terminate and then successfully closes f.  

Now here is the problem, our brcmrec driver has a
close() function which isn't getting called when
main does the close, at least not all of the
time.  	  
We're beginning to think that if the helper thread
is in the middle of an ioctl or something then the
close works but it doesn't call the close on the
driver.  


I don't even know what kind of help to ask for
here, so feel free to poke at this any ways you
like.  I guess the bothersome part is that we have
a thread that doesn an open (did I mention it was
an exclusive open?) and then spawns a thread and
then does a close and we can't reopen the device
and the close part of our driver is never called.

Any ideas or hints?

thanks,
Ian Nelson
--------------Boundary-00=_TF1BQL80000000000000--
