Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSGHMNt>; Mon, 8 Jul 2002 08:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSGHMNs>; Mon, 8 Jul 2002 08:13:48 -0400
Received: from pD952ABA4.dip.t-dialin.net ([217.82.171.164]:61396 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316851AbSGHMNs>; Mon, 8 Jul 2002 08:13:48 -0400
Date: Mon, 8 Jul 2002 06:16:25 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Kevin Curtis <kevin.curtis@farsite.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Implementing a sockets address family
In-Reply-To: <7C078C66B7752B438B88E11E5E20E72E0EF423@GENERAL.farsite.co.uk>
Message-ID: <Pine.LNX.4.44.0207080604120.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Kevin Curtis wrote:
> 1) It seems that the only way you can tell if the socket is blocking or
> non-blocking is to looks at the flags or msghdr->flags on each function
> call.  Is this the case?  When the socket is set to non-blocking and a call
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

