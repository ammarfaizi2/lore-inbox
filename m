Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262904AbSJGHaD>; Mon, 7 Oct 2002 03:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbSJGHaD>; Mon, 7 Oct 2002 03:30:03 -0400
Received: from catv-d5de80ec.bp11catv.broadband.hu ([213.222.128.236]:37383
	"EHLO balabit.hu") by vger.kernel.org with ESMTP id <S262904AbSJGHaC>;
	Mon, 7 Oct 2002 03:30:02 -0400
Date: Mon, 7 Oct 2002 09:35:32 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] unix domain sockets bugfix
Message-ID: <20021007073532.GA15799@balabit.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found a bug with unix domain sockets in both kernels 2.2 and 2.4.
If the program issues a recvfrom() on a SOCK_DGRAM socket, and the sender
had no name, the sockaddr returned is not filled in.

The returned socklen is 2, but the sockaddr.family is not touched. A fix is
below:

--- af_unix.c~	Mon Feb 25 20:38:16 2002
+++ af_unix.c	Fri Oct  4 09:46:26 2002
@@ -1392,6 +1392,9 @@
 		       sk->protinfo.af_unix.addr->name,
 		       sk->protinfo.af_unix.addr->len);
 	}
+	else {
+		((struct sockaddr *) msg->msg_name)->sa_family = AF_UNIX;
+	}
 }
 
 static int unix_dgram_recvmsg(struct socket *sock, struct msghdr *msg, int size,


-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
