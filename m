Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbTANVrY>; Tue, 14 Jan 2003 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbTANVrP>; Tue, 14 Jan 2003 16:47:15 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:56847 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S264938AbTANVqJ>; Tue, 14 Jan 2003 16:46:09 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Changing argv[0] under Linux.
Date: Tue, 14 Jan 2003 21:55:02 +0000 (UTC)
Organization: Cistron
Message-ID: <b020vm$bpm$1@ncc1701.cistron.net>
References: <20030114185934.GA49@DervishD> <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1042581302 12086 62.216.29.67 (14 Jan 2003 21:55:02 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>On Tue, 14 Jan 2003, DervishD wrote:
>
>>     I'm not sure whether this issue belongs to the kernel or to the
>> libc, but I think that is more on the kernel side, that's why I ask
>> here.
>
>Last time I checked argv[0] was 512 bytes. Many daemons overwrite
>it with no problem.

No cigar. This stuff is all set up by the kernel on the stack;
in order you have

	Top of stack at 0xbfffffff
	environ[0]\0environ[1]\0\0	From high ..
	argv[0]\0argv[1]\0\0
	*environ[];
	*argv[];			.. to low.

The kernel only reserves space as needed. If you have an empty
environment, and you copy 512 bytes over argv[0], you'll end
up with a SEGV.

If you want to modify argv[0] etc, loop over argv[], count howmuch
space there is (strlen(argv[0] + 1 + strlen(argv[1] + 1 ... etc)
and make sure you do NOT write a string longer than that. Also
make sure that you end the string with a double \0

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt

