Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274174AbRI3Uo6>; Sun, 30 Sep 2001 16:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274172AbRI3Uos>; Sun, 30 Sep 2001 16:44:48 -0400
Received: from colorfullife.com ([216.156.138.34]:64267 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274168AbRI3Uo3>;
	Sun, 30 Sep 2001 16:44:29 -0400
Message-ID: <3BB78442.A25BC8A5@colorfullife.com>
Date: Sun, 30 Sep 2001 22:44:50 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Christian Robottom Reis <kiko@async.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: ps -ax hang with Mozilla in 2.4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> 
> > > Just wondering if anybody has had moz hanging on them and hanging
> > > 'ps -ax'
> > > (which means /proc/kmem reading is hung, IIRC)?
> >
> > Modern Linux "ps" does not use /proc/kmem. Do a "strace ps" to see.
> > Maybe /proc/12345/stat or /proc/12345/status is hanging.
> 
> Thanks; if I can get this to be reproduced again I'll try. If read() on
> stat or status is hanging, something is very wrong, though, right?

Probably you ran into the bug Ulrich Weigand found:
access_process_vm can deadlock, especially with multithreaded apps.
Access_process_vm is used by /proc/*/cmdline.

It's fixed in 2.4.10.

--
	Manfred
