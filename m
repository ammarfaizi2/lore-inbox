Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318848AbSG0Wpn>; Sat, 27 Jul 2002 18:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSG0Wpm>; Sat, 27 Jul 2002 18:45:42 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:1716 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318848AbSG0Wpl>; Sat, 27 Jul 2002 18:45:41 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Rik van Riel" <riel@conectiva.com.br>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 15:49:46 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECEEPICPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L.0207271933200.3086-100000@imladris.surriel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's still there, but they say not to enable it...

There was a memory leak in the segmap and the only way pages would get freed
was by the scanner waking up (in the manner explained earlier). richard
mcdougald wrote an article about this called the paging storm.

They implemented a new system that still tends to give preference to
filesystem pages called a cyclical page cache. I haven't seen any
whitepapers on how it works though.

I wouldn't call it embarrasing though, they still recommend that you always
run it on pre-Solaris 8 systems because it tends to improve performance by
quite a bit on systems where there is lot's of filesystem I/O.

--Buddy



-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Saturday, July 27, 2002 3:35 PM
To: Alan Cox
Cc: Buddy Lumpkin; Austin Gonyou; vda@port.imtp.ilyichevsk.odessa.ua;
Ville Herva; DervishD; Linux-kernel
Subject: RE: About the need of a swap area


On 28 Jul 2002, Alan Cox wrote:
> On Sat, 2002-07-27 at 23:22, Buddy Lumpkin wrote:
> > I thought linux worked more like Solaris where it didn't use any swap
(AT
> > ALL) until it has to... At least, I hope linux works this way.
>
> I'd be suprised if Solaris did something that dumb.
>
> You want to push out old long unaccessed pages of code to make room for
> more cached disk blocks from files.

AFAIK they quietly removed priority paging from Solaris 8,
somewhat embarrasing considering the publicity at its
introduction with Solaris 7, but no more embarrasing than
the regular VM rewrites Linux undergoes ;/

Now only if VM was a well-understood area and we could just
implement something known to work ... OTOH, that would take
away all the fun ;)

cheers,

Rik
--
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

