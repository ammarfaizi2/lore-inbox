Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTDGHGM (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 03:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTDGHGM (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 03:06:12 -0400
Received: from desnol.ru ([217.150.58.11]:17416 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id S263298AbTDGHGL (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 03:06:11 -0400
Date: Mon, 7 Apr 2003 10:21:56 +0400
From: Vitaly <manushkinvv@desnol.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-Id: <20030407102156.1ab8546c.manushkinvv@desnol.ru>
In-Reply-To: <b6r6ms$tuj$1@abraham.cs.berkeley.edu>
References: <3E907A94.9000305@kegel.com>
	<1049663559.1602.46.camel@dhcp22.swansea.linux.org.uk>
	<b6qo2a$ecl$1@cesium.transmeta.com>
	<b6r24v$f50$1@cesium.transmeta.com>
	<b6r6ms$tuj$1@abraham.cs.berkeley.edu>
Organization: Desnol, grp
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.9; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Apr 2003 06:43:40 GMT
daw@mozart.cs.berkeley.edu (David Wagner) wrote:

> H. Peter Anvin wrote:
> >Here is a better piece of sample code that actually shows a
> >permissions violation happening:
> >
> >[...]
> >mkdir("testdir", 0700)                  = 0
> >open("testdir/testfile", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
> >write(3, "Ansiktsburk\n", 12)           = 12
> >close(3)                                = 0
> >open("testdir/testfile", O_RDONLY)      = 3
> >chmod("testdir", 0)                     = 0
> >open("/proc/self/fd/3", O_RDWR)         = 4
> >write(4, "Tjo fidelittan hatt!\n", 21)  = 21
> 
> You're right!  Good point. I retract the comments in my previous email.
> (I did try an experiment like this, but apparently not the right one.)
> 
> My conclusion: /proc/*/fd is a security hole.  It should be fixed.
> Do you agree?
open("/proc/self/fd/3", O_RDWR) -- i thought, it just makes a copy for fd/3, and fd/3 should have the same permissions as it was opened.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
