Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUJQSxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUJQSxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUJQSxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:53:52 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:45842 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S268223AbUJQSxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:53:49 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <martijn@entmoot.nl>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sun, 17 Oct 2004 11:53:36 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEBNPBAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <000801c4b46f$b62034b0$161b14ac@boromir>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sun, 17 Oct 2004 11:30:18 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sun, 17 Oct 2004 11:30:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is perfectly possible to not have a million things happen between
> select() and recvmsg() and POSIX defines what can happen and what
> can't; it states that a process calling select() on a socket will
> not block
> on a subsequent recvmsg() on that socket.

	I'm sorry, that's an absolutely preposterous view. For one thing, Linux
violates this by allowing processes and threads to share file descriptors
(since another process can steal the data before the call to 'recvmsg'). Oh
well, I guess we'll have to take that out if we want to comply with POSIX on
'select' semantics.

> The way select() is defined in POSIX effectively means that once an
> application has done a select() on a socket, the data that caused
> select() to return is committed, i.e. it can no longer be dropped and
> should be considered received by the application; this has nothing
> to do with UDP being unreliable and being unreliable for the sake
> of it is not what UDP was meant for.

	Again, I think this is an absurd reading of the standard. No other status
function provides a future guarantee. And it's semantically ugly to have
'select' change the status of network data when it's purely intended to be a
'get status' function.

> Whether you think an application that is written to use select() as
> defined in POSIX is broken is not really important. The fact remains
> that Linux currently implements a select() that is _not_ POSIX
> compliant and is so solely for performance reasons. I personally think
> correct behaviour is much more important.

	This is only because you interpret the standard as providing a future
guarantee that it is literally impossible for any modern operating system to
provide. I certainly don't interpret the standard that way. Look up the word
'would' in the dictionary.

	Linux does in fact make the decision to discard the data *after* the call
to 'select'. This is not in any way different from another process that
shared the file descriptor consuming the data after the call to 'select'.

	DS


