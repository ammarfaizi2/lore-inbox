Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbTCLPMB>; Wed, 12 Mar 2003 10:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbTCLPMB>; Wed, 12 Mar 2003 10:12:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51214 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261583AbTCLPMA>; Wed, 12 Mar 2003 10:12:00 -0500
Date: Wed, 12 Mar 2003 07:20:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Szakacsits Szabolcs <szaka@sienet.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
In-Reply-To: <1047464392.1556.4.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.44.0303120717270.13807-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Mar 2003, Arjan van de Ven wrote:
> 
> and all vendors always ship -fno-frame-pointer kernels so far so those
> users are ok! Until recently there was no way to build a non
> -fno-frame-pointer kernel!

Not entirely true.

Even with the traditional -fomit-frame-pointer build, "sched.c" has always
been built with -fno-fomit-frame-pointer in order to get the correct
"wchan" of callers of schedule() and wait_on().

See kernel/Makefile for details.

So yes, old kernels (and CONFIG_FRAME_POINTER=n) have traditionally
avoided the bug _mostly_. But it could still bite us in some rather
important functions.

		Linus

