Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278338AbRJWWA6>; Tue, 23 Oct 2001 18:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278332AbRJWWAl>; Tue, 23 Oct 2001 18:00:41 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:28676 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S278339AbRJWV7g>;
	Tue, 23 Oct 2001 17:59:36 -0400
Date: Wed, 24 Oct 2001 01:01:00 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@u.domain.uli>
To: Tim Hockin <thockin@sun.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
Message-ID: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Tim Hockin wrote:

> If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
> get inconsistent behavior when downing them.
>
> * if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
> * if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too
>
> I assert that this should not happen.  I have a simple patch to fix this
> behavior, but I want to know a few things.
>
> * Is this supposed to happen? Why?
> * Is it correct that both the real interface and the first alias are marked
> as primary (! IFA_F_SECONDARY), while all other aliases are secondary?  It

	If you look again into the sources you can see that
secondary addresses are those that are attached when there is
already IP address from the same subnet. The aliases don't play
here nor their number. The analyze points that the semantic
covers the selection of source addresses (probably when you don't
use preferred source address in your routes) and in some way they
look as an IP address lookup and kernel routes handling
optimizations. The other thing that I don't know is that may be
there is some compatibility reasons for such secondary flag.

> seems to me that ALL ALIASES should be secondary.  Is this wrong? Why?

	IMO, to keep the semantic of "attaching or detaching an IP
address" clear and independent, all addresses should be primary
because it is hard to keep correct setup when it is dynamicaly
changed. There is already mechanism (the scope) to make one address
"secondary" in the source address selection mechanism or even there
is a preferred source to make it primary. This is my opinion but
may be I'm missing some other usage. At least, the current handling
looks very dangerous.

Regards

--
Julian Anastasov <ja@ssi.bg>

