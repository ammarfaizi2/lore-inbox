Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTFDMGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTFDMGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:06:36 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:25828 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263273AbTFDMGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:06:35 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jesse Pollard <jesse@cats-chateau.net>
Date: Wed, 4 Jun 2003 14:19:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: select for UNIX sockets?
Cc: linux-kernel@vger.kernel.org, khc@pm.waw.pl
X-mailer: Pegasus Mail v3.50
Message-ID: <37356546941@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jun 03 at 6:55, Jesse Pollard wrote:
> On Monday 02 June 2003 19:08, Krzysztof Halasa wrote:
> > Hi,
> >
> > Should something like this work correctly?
> >
> > while(1) {
> >         FD_ZERO(&set);
> >         FD_SET(fd, &set);
> >         select(FD_SETSIZE, NULL, &set, NULL, NULL); <<<<<<< for writing
> >
> >         if (FD_ISSET(fd, &set))
> >                 sendto(fd, &datagram, 1, 0, ...);
> > }
> >
> > fd is a normal local datagram socket. It looks select() returns with
> > "fd ready for write" and sendto() then blocks as the queue is full.
> >
> > I don't know if it's expected behaviour or just a not yet known bug.
> > Of course, I have a more complete test program if needed.
> >
> > 2.4.21rc6, haven't tried any other version.
> >
> > strace shows:
> >
> > select(1024, NULL, [3], NULL, NULL)     = 1 (out [3])
> > sendto(3, "\0", 1, 0, {sa_family=AF_UNIX, path="/tmp/tempUn"}, 13 <<<
> > blocks
> 
> Could. There may be room for the buffer, but unless it is set to nonblock, 
> you may have a stream open to another host that may not accept the data (busy,
> network congestion...) With the required acks, the return may (should?) be
> delayed until the ack arrives.

Besides that select() on unconnected socket is nonsense... If you'll
change code to do connect(), select(), send(), then it should work,
unless I missed something.
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz

