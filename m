Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbRF0RyN>; Wed, 27 Jun 2001 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264669AbRF0RyE>; Wed, 27 Jun 2001 13:54:04 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:6157 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S264532AbRF0Rx6>;
	Wed, 27 Jun 2001 13:53:58 -0400
Date: Wed, 27 Jun 2001 19:56:46 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Jonathan Lundell <jlundell@pobox.com>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
In-Reply-To: <p05100303b75fa2bd0b7a@[207.213.214.37]>
Message-ID: <Pine.LNX.4.30.0106271919520.16282-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> PAGE_OFFSET definitely works for me, but a quick scan of the headers
> suggests that non-sun3 m68k builds define PAGE_OFFSET as 0, as does
> s390.

Hum - is there no simple way to determine whether a pointer is
a valid pointer to something returned by __get_free_pages ()? You are
right, S390 in particular seems to allow arbitrary addresses starting from
0.

> Sure, the overloading is self-admittedly hacky, but (again I assume)
> the motivation was to avoid breaking the clients, many of which are
> not in the kernel.org tree. Your proposed change overloads a third
> interpretation on start, namely an arbitrary pointer, outside the
> page allocation.

For some reason I was convinced that this was the originally intended
use of start. The only quotes I find right now are Ori Pomerantz'
Module Programming Guide (http://www.linuxdoc.org/LDP/lkmpg/node16.html)
and Rubini's "Writing Device Drivers", chapter 4. Also, the comment in the
code
		if (!start) {
			/*
			 * For proc files that are less than 4k
			 */
		...
		}
supports this notion somehow (start only set if data size > page size).

After all, unless you want to mangle the file position as intended by
the hack, there is no point in touching start at all in proc_read (),
ppos will be updated automatically.

Perhaps I have misunderstood something here.
Who wrote the original code, after all?

Martin

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



