Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSKPENP>; Fri, 15 Nov 2002 23:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSKPENP>; Fri, 15 Nov 2002 23:13:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36877 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265382AbSKPENO>; Fri, 15 Nov 2002 23:13:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: lan based kgdb
Date: Sat, 16 Nov 2002 04:19:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ar4h11$g7n$1@penguin.transmeta.com>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr>
X-Trace: palladium.transmeta.com 1037420406 10925 127.0.0.1 (16 Nov 2002 04:20:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Nov 2002 04:20:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021115222430.GA1877@tahoe.alcove-fr>,
Stelian Pop  <stelian.pop@fr.alcove.com> wrote:
>	  
>	* the USB stack seems simpler than the net stack + 
>	  (eventualy) pcmcia + network card driver.

What drugs are you on? The USB stack is extremely complex and fragile,
and depends on a lot more working than just about any network driver out
there. We're still debugging basic USB functionality.

Yes, if you're comparing to a full TCP implementation, plain USB serial
lines may be simpler (ignoring for the moment the fact that there isn't
even a standard USB serial line protocol, and they may be going the same
way as the hardware serial lines - the way of the dodo). 

But it should be possible to do a really simple UDP-packets-only thing
for kgdb.  Sure, it may lose packets.  Tough.  Don't debug over a WAN,
and try to keep a clean direct network connection if you are worried
about it.  But we want kernel printk's to be synchronous anyway, without
timeouts etc.

And I suspect you're better off losing packets (very rarely over any
normal local network) if that means that your debugger needs only
minimal support. You can always re-type.

		Linus

