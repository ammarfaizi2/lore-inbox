Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268124AbTAJD0j>; Thu, 9 Jan 2003 22:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268125AbTAJD0i>; Thu, 9 Jan 2003 22:26:38 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:16119 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S268124AbTAJD0i>; Thu, 9 Jan 2003 22:26:38 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.16227.924630.143293@wombat.chubb.wattle.id.au>
Date: Fri, 10 Jan 2003 14:34:59 +1100
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, eric@andante.org,
       linux-kernel@vger.kernel.org
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
In-Reply-To: <1345590000.1042169011@localhost.localdomain>
References: <15902.14667.489252.346007@wombat.chubb.wattle.id.au>
	<1345590000.1042169011@localhost.localdomain>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew McGregor <andrew@indranet.co.nz> writes:

Andrew> --On Friday, January 10, 2003 14:08:59 +1100 Peter Chubb
Andrew> <peter@chubb.wattle.id.au> wrote:

>> In linux 2.5.54, multiple links to the same file on a rock-ridge CD
>> have different inode numbers.  This confuses cpio, tar and cp -ra
>> because the multiple links are each copied separately as a single
>> file.
>> 
>> It'll probably also confuse NFS, but I haven't tried that.

Andrew> Shouldn't do, but it will probably make the buffer cache on
Andrew> the server less effective.

>> Currently the inode number appears to be the offset in bytes from
>> the start of the file system to the iso directory entry.  Files
>> with multiple directory entries (i.e., links) therefore have
>> different inums.
>> 
>> I don't know enough about the ISO9660 standard to be sure what's
>> best to do about this.

Andrew> Change it to be the offset to the data area, which should be
Andrew> the same for all of them?

I thought about that, but I'm unsure if there's any way to get from
that offset to the directory information.  As far as I can tell,
there's no concept of an inode separate from directory entry on iso9660
--- the directory entry/entries all contain all the information that
describes a file.  Which means that the inumber has to point to some
directory node.

Preferably, all the inumbers for the same file would point to the same
directory entry; but I can see no easy way to do that.  Keeping an
in-memory table for files with multiple links might be the best way,
as there aren't that many on a typical filesystem.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
