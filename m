Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSKKDyp>; Sun, 10 Nov 2002 22:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSKKDyo>; Sun, 10 Nov 2002 22:54:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265409AbSKKDyo>;
	Sun, 10 Nov 2002 22:54:44 -0500
Date: Sun, 10 Nov 2002 20:00:11 -0800 (PST)
Message-Id: <20021110.200011.39698409.davem@redhat.com>
To: plars@linuxtestproject.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: recvfrom/recvmsg
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1036792764.17557.24.camel@plars>
References: <1036792764.17557.24.camel@plars>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Larson <plars@linuxtestproject.org>
   Date: 08 Nov 2002 15:59:24 -0600
   
   Right now (2.5.46-bk current) I'm getting -1, errno 22 returned, but in
   2.5.46 it was passing without error.  Was this change intentional
   (probably) and is that the correct errno to return.  I checked SuS, but
   I don't see anything related to that exact condition.
   
No idea.  But -1 is invalid.

   There is another test in the same program that also looks like it should
   be failing.  Recvfrom, testcase 3 tries to do a recvfrom with (struct
   sockaddr *)-1 passed as the from buffer.  Right now, it is passing
   without an error, but that doesn't seem correct.

If namelen is zero, no attempt is made to access the sockaddr pointer.
Returning -EFAULT is always variable and no system call can guarentee
to return this so no test should require it to be returned.

