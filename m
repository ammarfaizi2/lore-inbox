Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbSKSJin>; Tue, 19 Nov 2002 04:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSKSJin>; Tue, 19 Nov 2002 04:38:43 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:33015 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264883AbSKSJim>; Tue, 19 Nov 2002 04:38:42 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15834.2112.854137.981987@wombat.chubb.wattle.id.au>
Date: Tue, 19 Nov 2002 20:45:36 +1100
To: rmack@mackman.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Orinoco Lock Up
In-Reply-To: <665837332@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "rmack" == rmack  <rmack@mackman.net> writes:

rmack> I was sleapilly typing away from my laptop when my wireless LAN
rmack> connection hung.  The other end, a dual P3 system using a
rmack> generic ISA->PCMCIA adapter and an Orinoco Silver v6.06 card
rmack> had gone crazy.  I don't know if the whole system was locked up
rmack> or not but removing the Orinoco card and re-inserting fixed the
rmack> wireless LAN.


This is such a common problem, that I now run this little script all
the time.  It triggers once or twice a day most days; more if I'm
doing something that involves heavy network use.  FWIW, the later 2.5
kernels seem to be better than 2.4.19.

----
#!/bin/sh
tail -f /var/log/kern.log |
while read f
do
    if expr "$f" \: '.*eth1: Error' > /dev/null 2>&1
    then
	cardctl reset
    fi
done
