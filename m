Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbRBCSDt>; Sat, 3 Feb 2001 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRBCSDj>; Sat, 3 Feb 2001 13:03:39 -0500
Received: from hetman.loiv.torun.pl ([158.75.57.4]:30157 "EHLO loiv.torun.pl")
	by vger.kernel.org with ESMTP id <S129145AbRBCSDY>;
	Sat, 3 Feb 2001 13:03:24 -0500
Date: Sat, 3 Feb 2001 19:04:19 +0100 (CET)
From: Krzysztof Rusocki <maxikazz@loiv.torun.pl>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG?] Unix Domain sockets in 2.4 series ?
Message-ID: <Pine.LNX.4.30.0102031844070.20382-100000@hetman>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I ain't kernel developer .. just poor little user,
but i think you might want to look at this stuff below...

I only tried that  little code remotely so  i do NOT know
what's system reaction on console ...

Anyway socket interface goes bye bye after this...

I tried it on 2.4.1-XFS and 2.4.0-XFS (both remotely)
and effects were exactly the same...

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
int main(int argc, const char* argv[])
{
	int retval;
	int sockets[2];
	char buf[1];
	retval = socketpair(PF_UNIX, SOCK_DGRAM, 0, sockets);
	if (retval != 0)
	{
		perror("socketpair");
		exit(1);
	}
	shutdown(sockets[0], SHUT_RDWR);
	read(sockets[0], buf, 1);
}


- Krzysztof

PS.
CC reply for me, i am not subscriber of lkml
thanks :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
