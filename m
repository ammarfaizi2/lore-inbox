Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbTAJIsd>; Fri, 10 Jan 2003 03:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264647AbTAJIsd>; Fri, 10 Jan 2003 03:48:33 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:504 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264646AbTAJIsc>; Fri, 10 Jan 2003 03:48:32 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.35492.536040.298566@wombat.chubb.wattle.id.au>
Date: Fri, 10 Jan 2003 19:56:04 +1100
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew McGregor <andrew@indranet.co.nz>, eric@andante.org,
       linux-kernel@vger.kernel.org
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
In-Reply-To: <200301100634.h0A6Yps14454@Port.imtp.ilyichevsk.odessa.ua>
References: <15902.14667.489252.346007@wombat.chubb.wattle.id.au>
	<1345590000.1042169011@localhost.localdomain>
	<15902.16227.924630.143293@wombat.chubb.wattle.id.au>
	<200301100634.h0A6Yps14454@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Denis" == Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:

Denis> On 10 January 2003 05:34, Peter Chubb wrote:
>> Preferably, all the inumbers for the same file would point to the
>> same directory entry; but I can see no easy way to do that.
>> Keeping an in-memory table for files with multiple links might be
>> the best way, as there aren't that many on a typical filesystem.

Denis> And what will happen on a non-typical filesystem with 1 million
Denis> hardlinks?

Denis> The root of the problem is a fundamental layering violation in
Denis> traditional Unix filesystems: inode numbers should NOT be
Denis> visible to userspace. Userspace just needs a way to tell
Denis> hardlinks from separate files, that's all. Exposing inumbers
Denis> does that, but creates tons of problems for filesystems which
Denis> do NOT have such a concept.

The problem is that in Unix the fundamental identity of a file is
the tuple (blkdev, inum); names are merely indices (links) that resolve to
that tuple.   Personally, I'd swap to a pair of system calls to map
name to (blkdev, inum), and open(blkdev, inum).  Think of the inode
number as a unique within-filesystem index.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.

