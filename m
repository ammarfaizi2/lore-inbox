Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTGGEJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 00:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264666AbTGGEJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 00:09:27 -0400
Received: from mpls-qmqp-03.inet.qwest.net ([63.231.195.114]:18189 "HELO
	mpls-qmqp-03.inet.qwest.net") by vger.kernel.org with SMTP
	id S264650AbTGGEJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 00:09:26 -0400
Date: Sun, 6 Jul 2003 23:20:42 -0700
Message-ID: <000d01c3444f$e6439600$6801a8c0@oemcomputer>
From: "Paul Albrecht" <palbrecht@qwest.net>
To: "Nivedita Singhvi" <niv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "netdev" <netdev@oss.sgi.com>
References: <3F08858E.8000907@us.ibm.com> <001a01c3441c$6fe111a0$6801a8c0@oemcomputer> <3F08B7E2.7040208@us.ibm.com>
Subject: Re: question about linux tcp request queue handling
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi writes:

>
> When you set a the backlog to 1 in the listen call, what is
> being capped is the accept queue. So I would expect your
> server to allow only one of those requests in the accept
> queue, and the kernel will drop the other two requests.
>

What you get when you set backlog to one is operating system dependent.
Tracing the flows with tcpdump, I get two clean handshakes so presumeably,
for linux, one means two.  The third connection request *isn't* dropped;
according to netstat, it's placed in the syn_recd state.  I thought
berkeley-derived implementations followed the rule that if there is no room
on the backlog queue for the new connection, tcp ignored the the received
syn.

>
> Actually, details, but we also apply some other conditions
> before we actually drop the connection request - we try not to be
> so harsh if the syn queue is still fairly empty..
>

Irrespective of whatever conditions linux applies, how can the connection
enter the syn_recd state if the backlog limit would be exceeded?  What's the
client supposed to do with the syn/ack from the server? What's the server
supposed to do with the ack it get's back from the client?


