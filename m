Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbRBSOEZ>; Mon, 19 Feb 2001 09:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130305AbRBSOEQ>; Mon, 19 Feb 2001 09:04:16 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:32524 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S130267AbRBSOEL>; Mon, 19 Feb 2001 09:04:11 -0500
Date: Mon, 19 Feb 2001 14:04:04 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: sendfile from char device?
Message-ID: <Pine.LNX.4.10.10102191356240.11164-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking for a fast way to initialise a file to zeroes
(without holes) and reckoned that sendfile from /dev/zero
would be the way to go.

But, unfortunately, sendfile (in 2.2 and 2.4) appears not
to support sendfile(2)ing a device:

$ cat foo.c
main()
{
	if(sendfile(1, 0, 0, 1024) < 0)
		perror("failed");
}
$ cc foo.c
$ ./a.out </etc/passwd >/dev/null
$ ./a.out </dev/zero >/tmp/test
failed: Invalid argument

I haven't played the printk game, but it looks like it may
be tripping up on the fact that devices don't support locks.
Or is it the lack of a ->readpage() method on /dev/zero?

Matthew.

