Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129222AbQKJLWH>; Fri, 10 Nov 2000 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129339AbQKJLV6>; Fri, 10 Nov 2000 06:21:58 -0500
Received: from web1103.mail.yahoo.com ([128.11.23.123]:11270 "HELO
	web1103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129222AbQKJLVs>; Fri, 10 Nov 2000 06:21:48 -0500
Message-ID: <20001110112146.12035.qmail@web1103.mail.yahoo.com>
Date: Fri, 10 Nov 2000 12:21:46 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Linux 2.2.18pre21
To: Matti Aarnio <matti.aarnio@zmailer.org>,
        Constantine Gavrilov <const-g@xpert.com>
Cc: willy tarreau <wtarreau@yahoo.fr>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't like to call it BONDING.
> "Bonding" is something where two (or more) channels
> carry data in between two participating systems.
> Like Multilink-PPP, and ISDN Channel Bonding.  Often
> indeed data goes out somehow inter-leaved on the
> physical links.  (Like ISDN Channel Bonding supplies
> a transparent 128 kbps link instead of two 64
> kbps links to the upper layers.)

this is *EXACTLY* what the old bonding driver does,
and what the new one does by default.

> EtherChannel does select the link (out of the group)
> by forming XOR of source and destination MAC
> addresses (their lowest bytes),
.../...
> This gives improved throughput on congested links
> in between two switches, or major server and core
> switches, while preserving data order over the
links.

OK, I've read about it because Thomas Davis asked me
if I would implement it. I didn't find it usefull for
the case of a Linux server directly connected to a
router or a level X switch (x>2) because in this case
only one link is getting used. Perhaps I'm wrong, but
I think this is the major use of the current Linux
bonding driver. However, the new driver is now ready
for such an implementation.

> Blind bonding-type "throw packets on links 0 and 1"
> MAY end up sending ethernet frames out of sequence,
> which for a few LAN based protocols is a great
source
> of upset.
probably, but do you have examples in mind ? if so, I
would add XOR to a next release, but I don't want to
add too much at a time. I consider this release
primarily as a bugfix (smp, security, oopses...), and
as an improvement which now supports link fail-over,
which is also a primary concern when implementing
multilinks.

> Beowulf systems have "bonding" in use for parallel
> Ethernet links in between two machines, however THAT
> is not EtherChannel compatible thing!

yes it is compatible ! compatible doesn't mean it does
not work the same way, but it works with. Both the
cisco and linux drivers agree to receive on each of
their trunk ports, so the difference only resides in
link optimization when sending frames.

> /Matti Aarnio

Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
