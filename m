Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286812AbSABHA1>; Wed, 2 Jan 2002 02:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286802AbSABHAH>; Wed, 2 Jan 2002 02:00:07 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34825 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286735AbSABG74>;
	Wed, 2 Jan 2002 01:59:56 -0500
Date: Wed, 2 Jan 2002 05:00:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, SteveW@ACM.org, jschlst@samba.org,
        ncorbic@sangoma.com, eis@baty.hanse.de, dag@brattli.net,
        torvalds@transmeta.com, marcelo@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH][RFC 5] cleaning up struct sock
Message-ID: <20020102050001.A19285@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This one turns IP_SK and IP6_PINFO usage the style TCP_PINFO and to
some extent IP6_PINFO (and its previous equivalents, sk->tp_pinfo.af_tcp
and sk->net_pinfo.ipv6), i.e., using a local variable to hold the result of
IP_SK/IP6_PINFO/TCP_PINFO and use this variable instead of the ugly
MACRO()->struct_member style. It also fixed a simple error in IP6_PINFO
that was causing oopses on IPv6 connections (it was using the tcp area).

	The fs unbork patch by Daniel Phillips also uses the same approach
wrt local variables.

	It still doesn't make the IPv6 family protocols use each a private
slabcache, i.e., there's still only one slabcache for all IPv6 protocols,
I'll work on this RSN.

	Patch available at:

http://www.kernel.org/pub/linux/kernel/people/acme/v2.5/2.5.2-pre6
sock.cleanup-2.5.2-pre6.bz2

	Comments and test results are welcome.

- Arnaldo
