Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTKKR3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTKKR3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:29:16 -0500
Received: from reptilian.maxnet.nu ([212.209.142.131]:50961 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S263637AbTKKR3E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:29:04 -0500
From: Thomas Habets <thomas@habets.pp.se>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: PROBLEM: Memory leak in -test9?
Date: Tue, 11 Nov 2003 18:27:12 +0100
X-Mailer: KMail [version 1.3.2]
References: <E1AJahk-00011D-00@reptilian.maxnet.nu> <20031111162734.GA29454@wohnheim.fh-wedel.de>
In-Reply-To: <20031111162734.GA29454@wohnheim.fh-wedel.de>
Cc: Henrik Storner <henrik@hswn.dk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C577XT2YE5PMF4OWE5DU"
Message-Id: <E1AJcJZ-0008Ts-00@reptilian.maxnet.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C577XT2YE5PMF4OWE5DU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 11 November 2003 17:27, Jörn Engel wrote:
> Looks familiar.  Can you recreate and send the output from
> /proc/slabinfo?

Oh, I didn't notice that file. :-)
Recreating is just booting and waiting for a week, but the box is still up.

This is the line that stands out (complete file attached, 137 lines).

tcp6_sock         111663 111664    960    4    1 : tunables   54   27    0 : 
slabdata  27916  27916      0

I seem to remember a changelog mentioning a leak being fixed in ipv6 code, 
but it looks like there may be another one? The only ipv6 service running is 
sshd, and the mrtg-sshs that go off every 5 minutes are NOT over ipv6. 
netstat -na shows nothing interesting. Only the ssh I connect with uses a bit 
of ipv6 (ffff:1.2.3.4). So, one listening socket, and one established.

$ cat /proc/net/sockstat6
TCP6: inuse 2
UDP6: inuse 0
RAW6: inuse 0
FRAG6: inuse 0 memory 0

$ cat /proc/net/rt6_stats 
0000 0006 0000 0008 0000 0008 0003

nothing over 6 in /proc/net/dev_snmp6/*

$ cat /proc/net/snmp6
Ip6InReceives                           223315
... just 0 ...
Ip6InDelivers                           223312
... just 0 ...
Ip6OutRequests                          223312
.. nothing that looks interesting ...


- ---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux 2.4" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/sRvwKGrpCq1I6FQRAqw1AKDVu+ZEvqwdoFPD18g6Ps1+UG62cACfTatK
pHUgMxWIGHke3USjtUEsKZU=
=/5YW
-----END PGP SIGNATURE-----

--------------Boundary-00=_C577XT2YE5PMF4OWE5DU
Content-Type: application/x-gzip;
  name="slabinfo.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="slabinfo.gz"

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
Z5bCwPeGQhoJQrYD+D+nM5p4PzkAAA==

--------------Boundary-00=_C577XT2YE5PMF4OWE5DU--
