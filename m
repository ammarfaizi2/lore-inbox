Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbREQW6I>; Thu, 17 May 2001 18:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbREQW56>; Thu, 17 May 2001 18:57:58 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:28176 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S262208AbREQW5v>; Thu, 17 May 2001 18:57:51 -0400
Date: Thu, 17 May 2001 23:57:45 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>
Subject: Kernel bug with UNIX sockets not detecting other end gone?
Message-ID: <Pine.LNX.4.30.0105172353480.13175-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I wonder if the following is a bug? It certainly differs from FreeBSD 4.2
behaviour, which gives the behaviour I would expect.

The following program blocks indefinitely on Linux (2.2, 2.4 not tested).
Since the other end is clearly gone, I would expect some sort of error
condition. Indeed, FreeBSD gives ECONNRESET.

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <unistd.h>

int
main(int argc, const char* argv[])
{
  int the_sockets[2];
  int retval;
  char the_char;
  int opt = 1;

  retval = socketpair(PF_UNIX, SOCK_DGRAM, 0, the_sockets);
  if (retval != 0)
  {
    perror("socketpair");
    exit(1);
  }
  close(the_sockets[0]);
  /* Linux (2.2) blocks here; FreeBSD does not */
  retval = read(the_sockets[1], &the_char, sizeof(the_char));
}

Cheers
Chris

