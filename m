Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132248AbQKDAxR>; Fri, 3 Nov 2000 19:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbQKDAxH>; Fri, 3 Nov 2000 19:53:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:937 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132248AbQKDAxD>;
	Fri, 3 Nov 2000 19:53:03 -0500
Date: Fri, 3 Nov 2000 16:38:12 -0800
Message-Id: <200011040038.QAA13178@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: phil@fifi.org
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <878zr0vbda.fsf@tantale.fifi.org> (message from Philippe Troin on
	03 Nov 2000 16:17:53 -0800)
Subject: Re: 2.2.x BUG & PATCH: recvmsg() does not check msg_controllen correctly
In-Reply-To: <87n1fgvl7a.fsf@tantale.fifi.org>
 <200011032218.OAA12790@pizda.ninka.net> <878zr0vbda.fsf@tantale.fifi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Philippe Troin <phil@fifi.org>
   Date: 03 Nov 2000 16:17:53 -0800

   Mmmh, no, if fdmax <= 0 (which happens when msg_controllen <
   sizeof(struct cmsghdr)), then alls fds are passed, eventually
   clobbering past ((char*)(msg_control)+m_controllen).

   Run the little test case if you're not convinced...
   I stand by my patch :-)

If fdmax <= 0, no iterations of the "for (i=0" loop will run.
'i' will therefore be left equal to zero.  Therefore the next
bit of code writing in the SOL_SOCKET/SCM_RIGHTS/etc. values
will not run.

Next comes the test I modified, which will set MSG_CTRUNC.

Next scm_destroy(scm) is called which frees the list (this has to get
called and is why I say your patch wasn't correct).

So where in this code are all the fds passed to the user in this case?
I don't care what it actually does, I want to be shown why because as
far as I see it doesn't do what you say it does.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
