Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTFFAYn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbTFFAYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:24:42 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:17050 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265270AbTFFAYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:24:41 -0400
Date: Fri, 6 Jun 2003 02:38:12 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
Message-ID: <20030606003812.GA31173@vana.vc.cvut.cz>
References: <37356546941@vcnet.vc.cvut.cz> <200306060028.h560SkYU002114@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306060028.h560SkYU002114@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 08:28:46PM -0400, Valdis.Kletnieks@vt.edu wrote: 
> On Wed, 04 Jun 2003 14:19:34 +0200, Petr Vandrovec said: 
> 
> > > >         FD_ZERO(&set);
> > > >         FD_SET(fd, &set);
> > > >         select(FD_SETSIZE, NULL, &set, NULL, NULL); <<<<<<< for writing
> > > >
> > > >         if (FD_ISSET(fd, &set))
> > > >                 sendto(fd, &datagram, 1, 0, ...);
> 
> > Besides that select() on unconnected socket is nonsense... If you'll
> > change code to do connect(), select(), send(), then it should work,
> > unless I missed something.
> 
> We FD_SET the bit, ignore the return value of select, and test if the bit is
> still set.  Plenty of programming bad karma there. However, one would vaguely
> hope that the kernel would notice that the socket isn't connected and -ENOTCONN
> rather than blocking....
 
You'll get ENOTCONN from send, just sendto blocks. select() returns that fd is
ready because this end of socket is ready, and there is probably at least one
UNIX socket on the system which is ready to accept data - so I think that it
is correct that select() returns data ready.

I think that whole problem comes from code's author idea that UNIX datagram 
sockets are equivalent to UDP through localhost while they are completely
different thing.
					Petr Vandrovec
					vandrove@vc.cvut.cz

