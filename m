Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318714AbSICJAV>; Tue, 3 Sep 2002 05:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318720AbSICJAV>; Tue, 3 Sep 2002 05:00:21 -0400
Received: from na.sdn.net.za ([66.8.40.138]:22797 "EHLO riva.fashaf.co.za")
	by vger.kernel.org with ESMTP id <S318714AbSICJAU>;
	Tue, 3 Sep 2002 05:00:20 -0400
From: mk@fashaf.co.za
Date: Tue, 3 Sep 2002 11:05:00 +0200
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18 Kernel Panics related to Netfilter/iptables
Message-ID: <20020903090500.GB8824@fashaf.co.za>
References: <20020902082156.GA28503@fashaf.co.za> <20020903125517.4decaeb9.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <20020903125517.4decaeb9.rusty@rustcorp.com.au>
X-Operating-System: Linux 2.4.18-3
X-Editor: VIM - Vi IMproved 6.1 (http://www.vim.org/)
X-Crypto: gpg (GnuPG) 1.0.7 (http://www.gnupg.org/)
X-GPG-Key-ID: AA91CF25
X-GPG-Key-Fingerprint: 8D0B F1A3 5296 6CBC 7509  05B0 F3B8 CEF2 AA91 CF25
X-What-Happen: somebody set up us the bomb.
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2 Sep 2002 10:21:56 +0200
> >=20
> > One of my machines running kernel 2.4.18 is getting kernel panics inter=
mittently (30minutes to 4/5 hours).=20
> >=20
> > from the logs I believe is the culprit:
> >=20
> > kernel: LIST_DELETE: ip_conntrack_core.c:165 `&ct->tuplehash[IP_CT_DIR_=
REPLY]'(c6c78e44) not in &ip_conntrack_hash [hash_conntrack(&ct->tuplehash[=
IP_CT_DIR_REPLY].tuple)].
>=20
> This problem has been plaguing us for a while.  You're using gcc 2.96, wh=
ich is interesting.
>=20
> What connection tracking/NAT modules have you got?
ipt_LOG ipt_limit ipt_state iptable_filter ipt_MASQUERADE iptable_nat

>  What kind of traffic are you getting? (eg. are you getting IRC traffic? =
 FTP traffic?).
There is nothing really to hectic that is using NAT as most of the traffic =
goes via a proxy. I'd say the only things that use NAT would be services th=
at dont support an http proxy, kazaa,edonkey,SMTP,pop.
The following ports are NAT'ed 25 22 80 (not really used) 9034 59651 4661 4=
662

This is the NAT part the gateway config:
$IPTABLES -t nat -A POSTROUTING -o $WAN -j MASQUERADE
$IPTABLES -A FORWARD -i $LAN -j ACCEPT
$IPTABLES -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPTABLES -A FORWARD -m limit --limit 3/minute --limit-burst 3 -j LOG --log=
-level DEBUG --log-prefix "IPT FORWARD packet died: "

Traffic is pretty low in general. If there is any other information i can g=
ive you please let me know.

Regards
Merritt
>=20
> I really want to chase this down, but I've yet to find the cause.
>=20
> Rusty.
> --=20
>    there are those who do and those who hang on and you don't see too
>    many doers quoting their contemporaries.  -- Larry McVoy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9dHs887jO8qqRzyURAvmfAJ0YTtaKZ+TLLSRsu/k6IY51jvjH/ACggs/c
hs98Y1WNfvmCHB8iE9th/oQ=
=23Yb
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
