Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266358AbUG0IjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266358AbUG0IjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266363AbUG0IjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:39:07 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:64004 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S266358AbUG0IjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:39:02 -0400
Date: Tue, 27 Jul 2004 10:39:47 +0200
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: The dreadful CLOSE_WAIT
Message-ID: <20040727083947.GB31766@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    Seems under Linux that, when a connection is in the CLOSE_WAIT
state, the only wait to go to LAST_ACK is the application doing the
'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.

    Well, I think this is dangerous because a bad application (and a
couple of widely used servers have this problem) can exhaust system
network resources (difficult, but possible). For example, a
concurrent FTP server with a race condition that doesn't do the
shutdown when the remote end aborts. Writing such a 'bad app' is very
easy, just do the socket->bind->listen->accept and after accepting
the connection forget the connected socket and keeps on listening. If
the remote end aborts, the server leaves the connection in
CLOSE_WAIT. Sometimes it has a associated timer, when data remains in
the tx queue, it seems that the kernel tries to retransmit all that
data, which makes no sense: in CLOSE_WAIT state the other end is not
there... Surely I'm missing a lot :((

    Since I don't know if a timeout (or another solution) exists to
avoid this I won't give names, but it's pretty easy to do a DoS
attack over a very known FTP server just using 'wget' and your
favourite C-c keys.

    IMHO, Linux (Unix) is about not allowing a bad app to screw the
system, and the CLOSE_WAIT state allows that. I know: you can screw
the system using as root an application that allocates and locks
large chunks of memory, or other 'legal' bad things, the sysadmin
should not allow the use of crappy software, but will do any harm a
CLOSE_WAIT timeout?

    Thanks a lot for your help :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
