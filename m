Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268294AbUJQTEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbUJQTEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUJQTEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:04:39 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:8156 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S268294AbUJQTEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:04:32 -0400
Message-ID: <003001c4b484$8999fe70$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "Lars Marowsky-Bree" <lmb@suse.de>, "Buddy Lucas" <buddy.lucas@gmail.com>,
       "Jesper Juhl" <juhl-lkml@dif.dk>
Cc: "David Schwartz" <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017150509.GC10280@mark.mielke.cc> <5d6b65750410170840c80c314@mail.gmail.com> <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost> <5d6b65750410171104320bc6a8@mail.gmail.com> <20041017180629.GO7468@marowsky-bree.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 21:04:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lars Marowsky-Bree" <lmb@suse.de>
>> [ snip ]
>> 
>> Also note the examples that Stevens gives. For instance, he explicitly
>> checks for EWOULDBLOCK after a read on a nonblocking fd that has been
>> reported readable by select().
>
> The specs don't disagree with that. On a O_NONBLOCK socket, that is
> allowed.

No, it isn't. select() may not behave differently based on the O_NONBLOCK
flag at the moment of the select() call. And if a call to recvmsg() with O_NONBLOCK
cleared doesn't block and since it can't return EAGAIN, then I don't think a recvmsg()
call with O_NONBLOCK set should return EAGAIN where something like
EIO should have been returned otherwise.


--ms

