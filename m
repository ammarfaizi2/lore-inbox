Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTFDLmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFDLmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:42:49 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:62190 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263246AbTFDLms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:42:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Krzysztof Halasa <khc@pm.waw.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
Date: Wed, 4 Jun 2003 06:55:47 -0500
X-Mailer: KMail [version 1.2]
References: <m3llwkauq5.fsf@defiant.pm.waw.pl>
In-Reply-To: <m3llwkauq5.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Message-Id: <03060406554700.28116@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 June 2003 19:08, Krzysztof Halasa wrote:
> Hi,
>
> Should something like this work correctly?
>
> while(1) {
>         FD_ZERO(&set);
>         FD_SET(fd, &set);
>         select(FD_SETSIZE, NULL, &set, NULL, NULL); <<<<<<< for writing
>
>         if (FD_ISSET(fd, &set))
>                 sendto(fd, &datagram, 1, 0, ...);
> }
>
> fd is a normal local datagram socket. It looks select() returns with
> "fd ready for write" and sendto() then blocks as the queue is full.
>
> I don't know if it's expected behaviour or just a not yet known bug.
> Of course, I have a more complete test program if needed.
>
> 2.4.21rc6, haven't tried any other version.
>
> strace shows:
>
> select(1024, NULL, [3], NULL, NULL)     = 1 (out [3])
> sendto(3, "\0", 1, 0, {sa_family=AF_UNIX, path="/tmp/tempUn"}, 13 <<<
> blocks

Could. There may be room for the buffer, but unless it is set to nonblock, 
you may have a stream open to another host that may not accept the data (busy,
network congestion...) With the required acks, the return may (should?) be
delayed until the ack arrives.
