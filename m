Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130129AbRCLNSs>; Mon, 12 Mar 2001 08:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRCLNSj>; Mon, 12 Mar 2001 08:18:39 -0500
Received: from roma.axis.se ([193.13.178.2]:4616 "EHLO roma.axis.se")
	by vger.kernel.org with ESMTP id <S130129AbRCLNSX>;
	Mon, 12 Mar 2001 08:18:23 -0500
Message-ID: <051e01c0aaf5$e5b5a4d0$0a070d0a@axis.se>
From: "Johan Adolfsson" <johan.adolfsson@axis.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Johan Adolfsson" <johan.adolfsson@axis.com>
Subject: select()/accept() problem in 2.0.38
Date: Mon, 12 Mar 2001 14:11:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short:
My listener socket _sometimes_ gets confused when a client 
connect and closes very fast when the server has outstanding data.

The read fd_set with the listener socket is not set
by the select() call for new connections, 
but if I do accept() on it anyway I will get the new socket!

I know this could happen anyway but if I don't do the accept()
the fd_set will not be set and the application will not handle
any new connections.
New clients will think they are connected depending on the
backlog parameter to listen(), and then they will timeout.

More details:
I use non-blocking sockets.

The select() has a timeout of 20ms since I need to
poll the serial port status pins.

I don't get this on 2.4.

When it happens I get a EPIPE from write(),
(sometimes it works but then I usually get ECONNRESET instead 
of EPIPE but not always)
It seems to be timing dependent.

Any ideas?

/Johan


