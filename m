Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312996AbSDYMht>; Thu, 25 Apr 2002 08:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313115AbSDYMhs>; Thu, 25 Apr 2002 08:37:48 -0400
Received: from elin.scali.no ([62.70.89.10]:12042 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S312996AbSDYMhq>;
	Thu, 25 Apr 2002 08:37:46 -0400
Subject: Possible bug with UDP and SO_REUSEADDR. Was Re: [PATCH] zerocopy
	NFS updated
From: Terje Eggestad <terje.eggestad@scali.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020420.164722.90116338.taka@valinux.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 25 Apr 2002 14:37:44 +0200
Message-Id: <1019738265.7409.1100.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing this mail from Hirokazu my curiosity triggered, I'd never
contemplated using reuse on a udp socket. 

However writing a test server that stand in blocking wait on a UDP
socket, and start two instances of the server it's ALWAYS the server
last started that get the udp message, even if it's not in blocking
wait, and the first started server is. 

Smells like a bug to me, this behavior don't make much sence. 

Using stock 2.4.17.

TJ


On Sat, 2002-04-20 at 09:47, Hirokazu Takahashi wrote:
> Hi,
> 
> > > And it seems to be more important on UDP sendfile().
> > > processes or threads sharing the same UDP socket would affect each other,
> > > while processes or threads on TCP sockets don't care about it as TCP
> > > connection is peer to peer.
> > 
> > No. It is not the lack of peer-to-peer connections that gives rise to the 
> > bottleneck, but the idea of several threads multiplexing sendfile() through a 
> > single socket. Given a bad program design, it can be done over TCP too.
> > 
> > The conclusion is that the programmer really ought to choose a different 
> > design. For multimedia streaming, for instance, it makes sense to use 1 UDP 
> > socket per thread rather than to multiplex the output through one socket.
> 
> You mean, create UDP sockets which have the same port number? 
> Yes we can if we use setsockopt(SO_REUSEADDR).
> And it could lead less contention between CPUs.
> Sounds good!
> 
> Thank you,
> Hirokazu Takahashi.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

