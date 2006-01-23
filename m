Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWAWSlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWAWSlK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAWSlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:41:10 -0500
Received: from sipsolutions.net ([66.160.135.76]:18705 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S964878AbWAWSlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:41:07 -0500
Subject: Re: [softmac-dev] [PATCH] ieee80211_rx_any: filter out packets,
	call ieee80211_rx or ieee80211_rx_mgt
From: Johannes Berg <johannes@sipsolutions.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "John W. Linville" <linville@tuxdriver.com>, jbenc@suse.cz,
       netdev@vger.kernel.org, softmac-dev@sipsolutions.net,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
In-Reply-To: <200601221404.52757.vda@ilport.com.ua>
References: <20060118200616.GC6583@tuxdriver.com>
	 <200601221404.52757.vda@ilport.com.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IdLNskD4tsjc3BegOMeQ"
Date: Mon, 23 Jan 2006 15:32:32 +0100
Message-Id: <1138026752.3957.98.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IdLNskD4tsjc3BegOMeQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-01-22 at 14:04 +0200, Denis Vlasenko wrote:
> +       hdr =3D (struct ieee80211_hdr_4addr *)skb->data;:=20
> +       fc =3D le16_to_cpu(hdr->frame_ctl);:=20
> +:=20
> +       switch (fc & IEEE80211_FCTL_FTYPE) {:=20
> +       case IEEE80211_FTYPE_MGMT:=20
> +               ieee80211_rx_mgt(ieee, hdr, stats);:=20
> +               return 0;:=20

Shouldn't you BSS-filter management packets too?

> +       is_packet_for_us =3D 0;:=20
> +       switch (ieee->iw_mode) {:=20
> +       case IW_MODE_ADHOC:=20
> +               /* promisc: get all */
> +               if (ieee->dev->flags & IFF_PROMISC):=20
> +                       is_packet_for_us =3D 1;

And I still think BSS-filtering is correct even in the promisc case. Any
other opinions why either way is right or not? [I think we should filter
because upper layers won't know the packet wasn't for us if it was
broadcast in another BSSID]

johannes

--=-IdLNskD4tsjc3BegOMeQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ9To/aVg1VMiehFYAQJORRAAuU/AJpoLxKBclt6QqQVDNqKWU1+9KuJY
ZIvRcRrM3JEA8hJwqenufU2vBpWZOMAPbjC2ra2877MP4q2oRDfYe+4nf4EXT6d7
SxyDn/+82PmNTXKgIZJ+oP5KyuWLVtekEZvxvui2EoKw2y1ijQARiHDu6smKF9HC
oAYmuSw/Q/H/uZLg5/E+IUxV9W1XBWRXHwvgc5FTiyGAqjthJIhj7l5lhki16p9D
EjEbTwVZ63pekxCEen74nL00zJHrYH++akEX5fO37w+R5XAI7W6rVo4c18J1eXhT
5h1fJ6n0QLaAmdla2BdO2ryvh9oUyLSY6NMTeWMVlxHBQLuSOMtjnqVkVJiwXYxV
dKpA/QzZ8dNVVGxu89Uw2OlKQPbKMzvbumIz4yOt8WN0+oAlV4jL6UNkVmIm9U9r
gR1f0J0SiQV94GhS9RbpZT0Al6ue0Y1e0AYDbhCdN5AEbVCdPXDsURks8dPYIBI+
rCCyngSou7RMgYlPA/kOke6KUMeW973KuDbtqOjcMQTHqJp42hYXfsVg5wCMprE6
hKsBw/omIIxYBVvBZL3I+t0RgVPjMWRF6Lt/fTfRmnTZql2fIvc2qpWDygvnL0nh
/T2mGF8C1WYhxA51KK4ekiy9LzLc6b+WjACEU584VH2bvig94G2Ac7q7+KjDLThG
EbsMRAqqUjs=
=2gig
-----END PGP SIGNATURE-----

--=-IdLNskD4tsjc3BegOMeQ--

