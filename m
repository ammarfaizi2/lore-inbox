Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbSLLBeO>; Wed, 11 Dec 2002 20:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbSLLBeO>; Wed, 11 Dec 2002 20:34:14 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:58630 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S267383AbSLLBeN>;
	Wed, 11 Dec 2002 20:34:13 -0500
Date: Wed, 11 Dec 2002 17:38:49 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: capable open_port() check wrong for kmem
Message-ID: <20021212013849.GA24054@net-ronin.org>
References: <20021210032242.GA17583@net-ronin.org> <at3v15$mur$1@abraham.cs.berkeley.edu> <20021210064134.GA17928@net-ronin.org> <20021210065159.GB17928@net-ronin.org> <20021211164348.A26790@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211164348.A26790@figure1.int.wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 04:43:48PM -0800, Chris Wright wrote:
[snip]
> If you have only one capability (CAP_SYS_RAWIO), you are not owner of
> /dev/kmem, you are in group kmem, and /dev/kmem is 0640, then all you will
> get is read-only access to /dev/kmem.  This does not require kernel changes.

So if I want to have a generic utility that can be used by any user (and
I'm not granting CAP_SYS_RAWIO to every process), then I can:

1) make it suid root
2) drop all caps other than cap_sys_rawio

or

1) add the capability to the executable, assuming it worked...

Script started on Wed Dec 11 17:29:14 2002
UB6IB9:/home/ramune/src/hack# setcap 'cap_sys_rawio=eip' ./a.out
Failed to set capabilities on file `./a.out'
 (Function not implemented)
usage: setcap [-q] (-|<caps>) <filename> [ ... (-|<capsN>) <filenameN> ]
UB6IB9:/home/ramune/src/hack# mount
/dev/hda1 on / type ext3 (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
UB6IB9:/home/ramune/src/hack# uname -a
Linux UB6IB9 2.4.20 #1 Sat Nov 30 20:51:01 PST 2002 i586 unknown
UB6IB9:/home/ramune/src/hack#
Script done on Wed Dec 11 17:29:31 2002

So, what am I missing?

I just have to make it suid root if I wanna use it on 2.4.x?  Or is there
a problem with my setup causing setcap to fail?

-- DN
Daniel
