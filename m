Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSKHEWl>; Thu, 7 Nov 2002 23:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKHEWl>; Thu, 7 Nov 2002 23:22:41 -0500
Received: from blount.mail.mindspring.net ([207.69.200.226]:43046 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S261590AbSKHEWj>; Thu, 7 Nov 2002 23:22:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mike Diehl <mdiehl@dominion.dyndns.org>
To: bert hubert <ahu@ds9a.nl>, "David S. Miller" <davem@redhat.com>
Subject: Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
Date: Thu, 7 Nov 2002 20:59:32 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
References: <20021107091822.GA21030@outpost.ds9a.nl> <20021107.025250.35525477.davem@redhat.com> <20021107130244.GA25032@outpost.ds9a.nl>
In-Reply-To: <20021107130244.GA25032@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021108023926.51B985606@dominion.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the IPSec in the 2.5 kernel actually works!!!  I had heard it was mostly 
nonfunctional.

This is good news.  FreeSwan has some quirky political policys.

On Thursday 07 November 2002 08:02 am, bert hubert wrote:
     > On Thu, Nov 07, 2002 at 02:52:50AM -0800, David S. Miller wrote:
     > > Really, if this one doesn't apply, your 2.5 bitkeeper tree is not
     > > totally uptodate.
     >
     > It works in transport mode! Both EH/ASP.
     >
     > Hints:
     > 	Use the latest bitkeeper sources as of Thurday morning MET
     >
     > 	Apply the last patch Alexey sent in the 'silly advise' thread
     > 		on linux kernel mailinglist
     >
     > 	Do not compile anything AH/ESP/CRYPTO as modules
     > 		failed for me with bad oops
     >
     > 	Make very very sure that you are not filtering ipsec packets
     > 		iptables needs to allow protocols 50 and 51
     >
     > 	Use the KAME tools port on ftp://ftp.inr.ac.ru/ip-routing/ipsec/
     > 		racoon won't compile, you don't need it yet
     > 		point it at your 2.5.46+bk+davem tree (edit GNUMakefiles)
     >
     > 	Use 3des-cbc
     > 		examples online use blowfish-cbc but that gives an error
     > 		in setkey
     >
     > Configuration (needs the setkey tool) on 10.0.0.11:
     >
     > #!./setkey -f
     > flush;
     > spdflush;
     >
     > # AH
     > add 10.0.0.11 10.0.0.216 ah 15700 -A hmac-md5 "1234567890123456";
     > add 10.0.0.216 10.0.0.11 ah 24500 -A hmac-md5 "1234567890123456";
     >
     > # ESP
     > add 10.0.0.11 10.0.0.216 esp 15701 -E 3des-cbc
     > "123456789012123456789012"; add 10.0.0.216 10.0.0.11 esp 24501 -E
     > 3des-cbc "123456789012123456789012";
     >
     > spdadd 10.0.0.216 10.0.0.11 icmp -P out ipsec
     >            esp/transport//use
     >            ah/transport//use;
     >
     > Configuration on 10.0.0.216:
     >
     > #!./setkey -f
     > flush;
     > spdflush;
     >
     > # AH
     > add 10.0.0.11 10.0.0.216 ah 15700 -A hmac-md5 "1234567890123456";
     > add 10.0.0.216 10.0.0.11 ah 24500 -A hmac-md5 "1234567890123456";
     >
     > # ESP
     > add 10.0.0.11 10.0.0.216 esp 15701 -E 3des-cbc
     > "123456789012123456789012"; add 10.0.0.216 10.0.0.11 esp 24501 -E
     > 3des-cbc "123456789012123456789012";
     >
     > # this is reversed
     > spdadd 10.0.0.11 10.0.0.216 icmp -P out ipsec
     >            esp/transport//use
     >            ah/transport//use;
     >
     > # ping 10.0.0.11
     > PING 10.0.0.11 (10.0.0.11) from 10.0.0.216 : 56(84) bytes of data.
     > 64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.11 ms
     >
     > $ sudo tcpdump -n -i eth0 -p
     > tcpdump: listening on eth0
     > 13:55:42.381669 10.0.0.216 > 10.0.0.11: AH(spi=0x00005fb4,seq=0x39):
     > ESP(spi=0x00005fb5,seq=0x39) (DF)
     > 13:55:42.382518 10.0.0.11 > 10.0.0.216: AH(spi=0x00003d54,seq=0x39):
     > ESP(spi=0x00003d55,seq=0x39)
     >
     > Great work everybody! I'm very impressed.
     >
     > Regards,
     >
     > bert

-- 
Mike Diehl
PGP Encrypted E-mail preferred.
Public Key via: http://dominion.dyndns.org/~mdiehl/mdiehl.asc

