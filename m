Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVJITRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVJITRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJITRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:17:47 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:46219 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750729AbVJITRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:17:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Content-Disposition:Date:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=IN/h3j7aF3IBOLoPkgfeE3pWFyg6j1D7e0Q2n/+QCiVacxk00Kw80Xsk94I8w/wFtRI0+wR5/3sl+3Uvq0afa1KJ7njC2AqAUlOu4xNOwJncc4cqGa6Ha8TeP2q6kyko0arJPda3EihADE90vtSYvJtv5fFLLhWwUHugWMbA0rI=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Uml left showstopper bugs for 2.6.14
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 9 Oct 2005 21:18:20 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a short and updated list of showstoppers for 2.6.14 release, from the 
UML point of view.

It's all things for which we (me and Jeff) have fixes, we are just in the 
progress of cleaning them and/or in the queues.

I initially read 2.6.14 ETA's was around October 7, when is it now?

However, here we go with the showstoppers (mostly regression):

1) problems with UBD (i.e. _the_ uml block driver): this is pretty dangerous 
and untrivial to fix, even if the code exists - so I and Jeff agreed to revert 
the change altogether. Jeff will send the thing.

2) Someone broke endianness of COW driver macros in a header cleanup. I have 
fixes.

3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. Jeff has 
the fix, waiting end of testing.

4) SKAS0 is broken with GCC 3.2.3, and potentially other GCC releases - look 
at arch/um/include/sysdep-i386/stub.h: stub_syscall*() to see how. I have two 
fixes, choosing the safer one (it's all just simply reusing code from 
<asm/unistd.h>).

5) Compile-time regression with SKAS mode disabled, will fix later (I'm going 
to have dinner now).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
