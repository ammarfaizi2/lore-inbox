Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280671AbRKJOt0>; Sat, 10 Nov 2001 09:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRKJOtP>; Sat, 10 Nov 2001 09:49:15 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:21642
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S280671AbRKJOtN>; Sat, 10 Nov 2001 09:49:13 -0500
From: arjan@fenrus.demon.nl
To: oktay.akbal@s-tec.de (Oktay Akbal)
Subject: Re: Numbers: ext2/ext3/reiser Performance (ext3 is slow)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0111101516050.14500-100000@omega.hbh.net>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E162ZQN-00069u-00@fenrus.demon.nl>
Date: Sat, 10 Nov 2001 14:47:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.40.0111101516050.14500-100000@omega.hbh.net> you wrote:

> Hello !

> Anyone has an idea, why this ext3 "fails" at this specific test while on
> normal fs-benchmarks it is much better ?

ext3 by default imposes stricter ordering than the other journalling
filesystems in order to improve _data_ consistency (as opposed to just
the guarantee of consistent metadata as most other filesystems do).
if you mount the filesystem with

mount -t ext3 -o data=writeback /dev/foo /mnt/bar

will make it use the same level of guarantee as reiserfs does.

mount -t ext3 -o data=journal /dev/foo /mnt/bar

will do FULL data journalling and will also guarantee data integrety after a
crash...

Greetings,
   Arjan van de Ven
