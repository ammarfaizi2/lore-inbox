Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314383AbSECOyN>; Fri, 3 May 2002 10:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSECOyN>; Fri, 3 May 2002 10:54:13 -0400
Received: from mail.ccur.com ([208.248.32.212]:41997 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S314383AbSECOyM>;
	Fri, 3 May 2002 10:54:12 -0400
Subject: 2.4.18+O(1) tcp timewait zombies
From: Jason Baietto <jason.baietto@ccur.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 May 2002 10:53:57 -0400
Message-Id: <1020437642.28612.55.camel@soybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After upgrading from stock 2.4.17 to 2.4.18 (with O(1) scheduler
patch) I'm seeing some strange networking behavior.  Basically,
upon exit rsh connections seem to go into TIME_WAIT, count down
to zero, and then stick around forever.  For example:

   compy$ rsh hyena echo hello < /dev/null
   hello
   compy$

This leaves a socket connnection in TIME_WAIT state:

   tcp        ...         TIME_WAIT   timewait (51.75/0/0)

However, the strange thing is that after the connection times
out, it sticks around.  I've got hundreds of these connections
open that look like this:

   tcp        ...         TIME_WAIT   timewait (0.00/0/0)

And never seem to go away.  Eventually, this causes me to
get this message whenever I try to do an new rsh:

   socket: All ports in use

Can anyone offer me any advice on how to debug this?

Take care,
Jason
--
Jason Baietto
jason.baietto@ccur.com


