Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313815AbSDUVMu>; Sun, 21 Apr 2002 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313821AbSDUVMt>; Sun, 21 Apr 2002 17:12:49 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1934 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S313815AbSDUVMs>;
	Sun, 21 Apr 2002 17:12:48 -0400
Date: Sun, 21 Apr 2002 22:53:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        david.lang@digitalinsight.com, vojtech@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [ENBD] [Fwd: Re: [PATCH] 2.5.8 IDE 36]
Message-ID: <20020421205312.GC12120@elf.ucw.cz>
In-Reply-To: <3CC00425.3060703@cjcj.com> <200204191307.g3JD7qX23492@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With it, the protocol in the client daemon will ack the kernel _before_
> it gets an ack from the remote server. That should help relieve the
> deadlock. Things then go like this:
> 
>      kernel runs low on memory
>      kernel flushes buffers to device drivers under pressure
>      nbd client daemon sends to the net
>         * client acks kernel and releases buffers in kernel
>      server on the _same machine_ receives request over the net
>      server tries to write request to disk
>      server process needs buffers to write to
>         * server gets buffers released by client in kernel
> 
> At least, potentially. If I recall right, there's still a deadlock
> window in-kernel, but it's small. I don't recall the details. Oh -
> well, the request still hangs around in the driver until the client
> daemon acks .. maybe the client daemon can't ack without being swapped
> in first, and that'd be deadlock.
> 
> Well, there's a "-s" flag (for swap devices) that does an mlockall()
> that might take care of that. So "-a -s" might do it. Really needs
> a "-aa" option (release write request in kernel asap).

Well, with mlockall(), I'd believe it could be made to work. Okay.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
