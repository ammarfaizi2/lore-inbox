Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJRDWW>; Thu, 17 Oct 2002 23:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJRDWW>; Thu, 17 Oct 2002 23:22:22 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:41467 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S262850AbSJRDWW>; Thu, 17 Oct 2002 23:22:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15791.32649.537730.293555@wombat.chubb.wattle.id.au>
Date: Fri, 18 Oct 2002 13:27:05 +1000
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] statfs64 no longer missing
In-Reply-To: <20021018023105.GA15931@averell>
References: <20021016140658.GA8461@averell>
	<shs7kgipiym.fsf@charged.uio.no>
	<15789.64263.606518.921166@wombat.chubb.wattle.id.au>
	<20021017000111.GA25054@averell>
	<20021017154102.D30332@redhat.com>
	<15791.21383.361727.533851@wombat.chubb.wattle.id.au>
	<20021018023105.GA15931@averell>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@muc.de> writes:

>> --- a/arch/i386/kernel/entry.S Fri Oct 18 10:07:29 2002 +++
>> b/arch/i386/kernel/entry.S Fri Oct 18 10:07:29 2002 @@ -737,6
>> +737,8 @@ .long sys_free_hugepages .long sys_exit_group .long
>> sys_lookup_dcookie + .long sys_statfs64 + .long sys_fstatfs64 /*
>> 255 */

Andi> Funny. Finally filling the 8bits for syscall numbers.


Yes. 

>> +long vfs_statfs64(struct super_block *sb, struct statfs64 *buf) +{
>> + struct kstatfs st; + int retval; + + retval = vfs_statfs(sb,
>> &st); + if (retval) + return retval; + + if (sizeof(*buf) ==
>> sizeof(st)) + memcpy(buf, &st, sizeof(st));

Andi> Don't you need to clear spare here too ?

I don't think so -- it's vfs_statfs() where *buf is zeroed --- the
memcpy copies the zeroed spare[] fields too.

Peter C
