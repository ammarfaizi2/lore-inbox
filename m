Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160390AbQG2NG0>; Sat, 29 Jul 2000 09:06:26 -0400
Received: by vger.rutgers.edu id <S160440AbQG2NGF>; Sat, 29 Jul 2000 09:06:05 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:1889 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160429AbQG2NES>; Sat, 29 Jul 2000 09:04:18 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 29 Jul 2000 13:23:49 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8lult5$q1q$1@enterprise.cistron.net>
In-Reply-To: <20000728232030.C8868@gnu.org>
X-Trace: enterprise.cistron.net 964877029 26682 195.64.65.200 (29 Jul 2000 13:23:49 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article <cistron.20000728232030.C8868@gnu.org>,
Adam Sampson  <azz@gnu.org> wrote:
>On Thu, Jul 27, 2000 at 07:03:57PM +0200, Jamie Lokier wrote:
>> But instead, how about a script: /lib/modules/VERSION/compile-module.
>> The script would know where to find the kernel headers.  That could be
>> /lib/modules/include for distributions, and /my/kernel/tree/include for
>> folks who used `make modules_install' recently.
>
>I'll second that suggestion. This kind of thing works very well indeed for
>projects like Apache.

It is indeed a very good idea. The script could just spit out the
CFLAGS used for kernel compilation like this:

#! /bin/sh
cat <<EOF
-D__KERNEL__ -I/usr/src/linux-2.2.15/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686 -DUTS_MACHINE='"i386"'
EOF

Then a module Makefile would be as simple as

# Set KVER manually if you want to compile against another kernel version
KVER=$(shell uname -r)
CFLAGS=$(shell /lib/modules/$(KVER)/kernel-config)

module.o: module.c module.h

I've tried this, it works.

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
