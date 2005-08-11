Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVHKB3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVHKB3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHKB3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:29:19 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:33973 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932130AbVHKB3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:29:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17146.43490.8672.13906@wombat.chubb.wattle.id.au>
Date: Thu, 11 Aug 2005 11:29:06 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: fcntl(F_GETLEASE) semantics??
In-Reply-To: <1123722848.8242.11.camel@lade.trondhjem.org>
References: <17146.37443.505736.147373@wombat.chubb.wattle.id.au>
	<1123722848.8242.11.camel@lade.trondhjem.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Trond" == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

Trond> to den 11.08.2005 Klokka 09:48 (+1000) skreiv Peter Chubb:
>> Hi, The LTP test fcntl23 is failing.  It does, in essence, fd =
>> open(xxx, O_RDWR|O_CREAT, 0777); if (fcntl(fd, F_SETLEASE, F_RDLCK)
>> == -1) fail;
>> 
>> fcntl always returns EAGAIN here.  The manual page says that a read
>> lease causes notification when `another process' opens the file for
>> writing or truncates it.  The kernel implements `any process'
>> (including the current one).
>> 
>> Which semantics are correct?  Personally I think that what the
>> kernel implements is correct (you can't get a read lease unsless
>> there are no writers _at_ _all_)

Trond> A read lease should mean that there are no writers at all.

Trond> If we were to allow the current process to open for write, then
Trond> that would still mean that nobody else can get a lease. In
Trond> effect you have been granted a lease with exclusive semantics
Trond> (i.e. a write lease). You might as well request that instead of
Trond> pretending it is a read lease.

So the manual page is wrong.  Fine.


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
