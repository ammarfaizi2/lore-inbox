Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSG0Wfe>; Sat, 27 Jul 2002 18:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318850AbSG0Wfe>; Sat, 27 Jul 2002 18:35:34 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:59550 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S318849AbSG0Wfd>; Sat, 27 Jul 2002 18:35:33 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Austin Gonyou" <austin@digitalroadkill.net>,
       <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Ville Herva" <vherva@niksula.hut.fi>, "DervishD" <raul@pleyades.net>,
       "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sat, 27 Jul 2002 15:39:41 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECOEPGCPAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1027813211.21516.2.camel@irongate.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, first off let's not turn this into a *ix vs. *ix type discussion, I
didn't mean to imply Solaris is more superior.

But that's exactly what it does. Solaris doesn't move *anything* to swap
until you reach a watermark called cachefree (which may or may not be equal
to lotsfree)

Why would you want to push *anything* to swap until you have to?

Dirty filesystem pages have to be flushed to disk, it's just a question of
when. Why on earth would I ever decide to move anonymous pages for any
process to disk if I can flush dirty pages to their backing store and put
non-dirty filesystem pages back on the freelist?

Like I said, it's very rare for my systems to do any I/O to swap at all.

and it's pretty relative what "long unaccessed" means ..

--Buddy


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Saturday, July 27, 2002 4:40 PM
To: Buddy Lumpkin
Cc: Austin Gonyou; vda@port.imtp.ilyichevsk.odessa.ua; Ville Herva;
DervishD; Linux-kernel
Subject: RE: About the need of a swap area


On Sat, 2002-07-27 at 23:22, Buddy Lumpkin wrote:
> I thought linux worked more like Solaris where it didn't use any swap (AT
> ALL) until it has to... At least, I hope linux works this way.

I'd be suprised if Solaris did something that dumb.

You want to push out old long unaccessed pages of code to make room for
more cached disk blocks from files.


