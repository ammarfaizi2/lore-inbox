Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSGHQTq>; Mon, 8 Jul 2002 12:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSGHQTp>; Mon, 8 Jul 2002 12:19:45 -0400
Received: from copper.ftech.net ([212.32.16.118]:24778 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S293680AbSGHQTo>;
	Mon, 8 Jul 2002 12:19:44 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF427@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Thunder from the hill'" <thunder@ngforever.de>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Implementing a sockets address family
Date: Mon, 8 Jul 2002 17:18:57 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	thanks for the reply.  From an application point of view, when a
socket is created it is non-blocking by default.  If the application uses
ioctl or fcntl to set the socket to non-blocking mode, then all I was saying
was I don't see any indication in flags or msghdr->flags as to whether the
user wants to wait for the recv to complete or not.  How is my recvmsg()
function in my implementation of the new address family supposed to
differentiate.  I cannot see any reference to O_NONBLOCK or MSG_DONTWAIT in
the tcp_recvmsg() function.


Kevin

-----Original Message-----
From: Thunder from the hill [mailto:thunder@ngforever.de]
Sent: 08 July 2002 13:16
To: Kevin Curtis
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implementing a sockets address family


Hi,

On Mon, 8 Jul 2002, Kevin Curtis wrote:
> 1) It seems that the only way you can tell if the socket is blocking or
> non-blocking is to looks at the flags or msghdr->flags on each function
> call.  Is this the case?  When the socket is set to non-blocking and a
call
> to the system recv() function is made, my recvmsg() function is called but
> neither the flags parameter nor the flags in the msghdr structure have any
> indication that the socket is non-blocking.  What am I missing here?

non-blocking is a matter of behavior. It easily doesn't block.

The man page says

 O_NONBLOCK or O_NDELAY
	When  possible,  the file is opened in non-blocking
	mode. Neither the open nor  any  subsequent  opera-
	tions on the file descriptor which is returned will
	cause the calling process to wait.   For  the  han-
	dling  of  FIFOs  (named  pipes), see also fifo(4).
	This mode need not have any effect on  files  other
	than FIFOs.

So it shouldn't work outside FIFOs. However, have a look at net/ipv4/tcp.c 
for more details.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------
