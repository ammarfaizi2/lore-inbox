Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314859AbSD2IGr>; Mon, 29 Apr 2002 04:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314862AbSD2IGq>; Mon, 29 Apr 2002 04:06:46 -0400
Received: from elin.scali.no ([62.70.89.10]:59660 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S314859AbSD2IGq>;
	Mon, 29 Apr 2002 04:06:46 -0400
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
From: Terje Eggestad <terje.eggestad@scali.com>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020429004153.AAA18838@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 10:06:43 +0200
Message-Id: <1020067604.22026.3.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-29 at 02:41, David Schwartz wrote:
> 
> 
> On Thu, 25 Apr 2002 19:43:01 -0700 (PDT), David S. Miller wrote:
> >From: Terje Eggestad <terje.eggestad@scali.com>
> >Date: 25 Apr 2002 14:37:44 +0200
> >
> >However writing a test server that stand in blocking wait on a UDP
> >socket, and start two instances of the server it's ALWAYS the server
> >last started that get the udp message, even if it's not in blocking
> >wait, and the first started server is.
> >
> >Smells like a bug to me, this behavior don't make much sence.
> >
> >Using stock 2.4.17.
> >
> >Can you post your test server/client application so that I
> >don't have to write it myself and guess how you did things?
> 
> 	There are really two possibilities:
> 
> 	1) The two instances are cooperating closely together and should be sharing 
> a socket (not each opening one), or
> 
> 	2) The two instances are not cooperating closely together and each own their 
> own socket. For all the kernel knows, they don't even know about each other.
> 
> 	In the first case, it's logical for whichever one happens to try to read 
> first to get the/a datagram. In the second case, it's logical for the kernel 
> to pick one and give it all the data.
> 
> 	DS
> 

IMHO, in the second case it's logical for the kernel NOT to allow the
second to bind to the port at all. Which it actually does, it's the
normal case. When you set the SO_REUSEADDR flag on the socket you're
telling the kernel that we're in case 1). 

TJ  

> 
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

