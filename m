Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTEPAac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264293AbTEPAab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:30:31 -0400
Received: from smtp3.server.rpi.edu ([128.113.2.3]:60322 "EHLO
	smtp3.server.rpi.edu") by vger.kernel.org with ESMTP
	id S264218AbTEPAa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:30:29 -0400
Mime-Version: 1.0
Message-Id: <p05210622bae9d966f847@[128.113.24.47]>
In-Reply-To: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
Date: Thu, 15 May 2003 20:43:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: [OpenAFS-devel] Re: Alternative to PAGs
Cc: linux-kernel@vger.kernel.org, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can see some advantage to the ability to switch into an
already-existing pag, so let me switch sides for a moment.

If someone came to me and would pay me to implement "something
just like a PAG, except that there must be an ability to join
an already-existing PAG", I would suggest the following:

    1) Creation of PAGs are handled exactly as they are now.
       Lightweight creation, etc.
    2) If the user of some already-existing PAG wants that
       PAG to be "join-able", they run some special command
       which registers the PAG with a name, and with the
       details of how to authenticate to that named-PAG.  One
       could select from a variety of authentication methods.
    3) Then from some other process (which would probably already
       have a PAG) could run a special setpag command, and if
       they provide the proper authentication, then that
       process would switch to the already-existing pag.

This isn't quite what Linus is looking for, but it provides some
of it without adding much overhead to the most common usage of
PAGs.  Step #2 should probably require that the user can not
register a name for a PAG unless they pass some authentication
test to prove that they can.  Ie, you don't want me to walk up
to your terminal, gesture excitedly at some fire across the
street, and then type in the 'register pag' command while you're
not paying attention to me or your computer.

Users won't know or care about the range for PAG values, because
they will only be dealing with the "registered names" for a PAG.

I still would prefer PAGs as they are, because I think this still
opens up some issues that I'd prefer to leave closed.  But I
think that would be doable.

I should probably also apologize to David here, because he's
actually doing useful work.  Here I'm just butting in because it
would be so great to see PAG support as part of linux, instead
of something we have to keep sticking on the side of it.  RPI
is moving our AFS cell to redhat linux servers, and the easier
it is for openafs on linux, the nicer it will be for us.

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
