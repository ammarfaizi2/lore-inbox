Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTBUVzy>; Fri, 21 Feb 2003 16:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTBUVzx>; Fri, 21 Feb 2003 16:55:53 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:33936 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267674AbTBUVzw>; Fri, 21 Feb 2003 16:55:52 -0500
Message-Id: <200302212205.h1LM5gCu016220@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: Mika Liljeberg <mika.liljeberg@welho.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN 
In-Reply-To: Your message of "Fri, 21 Feb 2003 23:43:58 +0200."
             <1045863838.22625.121.camel@devil> 
From: Valdis.Kletnieks@vt.edu
References: <200302212040.h1LKejY3001679@81-2-122-30.bradfords.org.uk>
            <1045863838.22625.121.camel@devil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1325935527P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Feb 2003 17:05:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1325935527P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <16207.1045865133.1@turing-police.cc.vt.edu>

On Fri, 21 Feb 2003 23:43:58 +0200, Mika Liljeberg said:

> That's right. Unfortunately, the way most people *will* deal with it is
> by turning ECN off permanently and forgetting about it. That won't help
> ECN become widely adopted.

That's what I'm trying to avoid doing. ;)

(As an aside, yes, the URL to the previous marc.theaimsgroup thread *is*
what I'm talking about).

It turns out that I *CAN* do it all with iptables *IF* the following
untested code actually works (this assumes that mangle is re-called on
a retransmit)

# If we've already marked this packet, strip/log/send...
iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 --ecn-tcp-remove
iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 -j LOG
iptables -t mangle -A OUTPUT -p tcp --syn -m mark --mark 99 -j ACCEPT
# Else tag it - if it makes it on the first try, good. If not, re-enter above
iptables -t mangle -A OUTPUT -p tcp --syn -m mark --set-mark 99

Does the mangle/output chain get called again for a retransmitted
packet, or only once?

/Valdis


--==_Exmh_1325935527P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+VqK1cC3lWbTT17ARAqREAKD+JikcCfss0CZnwPeERBxk6kks8QCdF5CI
r8e/aYoHssB4brFdmHpSCxQ=
=nX4u
-----END PGP SIGNATURE-----

--==_Exmh_1325935527P--
