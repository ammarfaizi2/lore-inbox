Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262816AbRE3Vva>; Wed, 30 May 2001 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262819AbRE3VvT>; Wed, 30 May 2001 17:51:19 -0400
Received: from [194.182.238.3] ([194.182.238.3]:22533 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S262816AbRE3VvN>; Wed, 30 May 2001 17:51:13 -0400
Date: Wed, 30 May 2001 23:47:26 +0200 (CEST)
From: "Rasmus B. Hansen" <moffe@amagerkollegiet.dk>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Marcus Meissner <mm@ns.caldera.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: ln -s broken on 2.4.5
In-Reply-To: <20010530233005.A27497@caldera.de>
Message-ID: <Pine.BSO.4.33.0105302341480.11171-100000@smaug.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Marcus Meissner wrote:

> The problem is only there if you specify a directory for the linked to
> component.

I do still not see those problems:

moffe@grignard:/tmp/test# ls -la
totalt 1
drwxr-xr-x    2 moffe    users          48 ons maj 30 23:43:46 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 23:43:54 2001 ..
moffe@grignard:/tmp/test# ln -s foo/test bar
moffe@grignard:/tmp/test# ls -la
totalt 1
drwxr-xr-x    2 moffe    users          72 ons maj 30 23:44:32 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 23:43:54 2001 ..
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:44:32 2001 bar -> foo/test
moffe@grignard:/tmp/test# mkdir test
moffe@grignard:/tmp/test# ln -s test/bar foo
moffe@grignard:/tmp/test# ls -la
totalt 2
drwxr-xr-x    3 moffe    users         120 ons maj 30 23:44:48 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 23:43:54 2001 ..
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:44:32 2001 bar -> foo/test
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:44:48 2001 foo -> test/bar
drwxr-xr-x    2 moffe    users          48 ons maj 30 23:44:40 2001 test
moffe@grignard:/tmp/test# mkdir test/foo
moffe@grignard:/tmp/test# ln -s test/foo foo2
moffe@grignard:/tmp/test# ls -la
totalt 2
drwxr-xr-x    3 moffe    users         144 ons maj 30 23:45:11 2001 .
drwxrwxrwt   13 root     root          496 ons maj 30 23:43:54 2001 ..
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:44:32 2001 bar -> foo/test
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:44:48 2001 foo -> test/bar
lrwxrwxrwx    1 moffe    users           8 ons maj 30 23:45:11 2001 foo2 -> test/foo
drwxr-xr-x    3 moffe    users          72 ons maj 30 23:45:01 2001 test

moffe@grignard:/tmp/test# uname -m
i586
moffe@grignard:/tmp/test# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)
moffe@grignard:/tmp/test# uname -r
2.4.5
moffe@grignard:/tmp/test# ldd --version
ldd (GNU libc) 2.2.3

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
If you don't receive an answer, then it either indicates that the bug is
too obvious or too difficult.
                                                       -- Manfred Spraul
-------------------------------- [ moffe at amagerkollegiet dot dk ] --

