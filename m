Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268388AbTAMXE3>; Mon, 13 Jan 2003 18:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268401AbTAMXE3>; Mon, 13 Jan 2003 18:04:29 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:60922 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S268388AbTAMXE0>; Mon, 13 Jan 2003 18:04:26 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15907.18251.658199.968745@wombat.chubb.wattle.id.au>
Date: Tue, 14 Jan 2003 10:10:03 +1100
To: Bill Davidsen <davidsen@tmr.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
In-Reply-To: <Pine.LNX.3.96.1030113165748.22949A-100000@gatekeeper.tmr.com>
References: <15902.16227.924630.143293@wombat.chubb.wattle.id.au>
	<Pine.LNX.3.96.1030113165748.22949A-100000@gatekeeper.tmr.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bill" == Bill Davidsen <davidsen@tmr.com> writes:

Bill> On Fri, 10 Jan 2003, Peter Chubb wrote:
>> >>>>> "Andrew" == Andrew McGregor <andrew@indranet.co.nz> writes:

Andrew> Change it to be the offset to the data area, which should be
Andrew> the same for all of them?
>> I thought about that, but I'm unsure if there's any way to get from
>> that offset to the directory information.  As far as I can tell,
>> there's no concept of an inode separate from directory entry on
>> iso9660 --- the directory entry/entries all contain all the
>> information that describes a file.  Which means that the inumber
>> has to point to some directory node.

Bill> I can see that you would have to carry that information forward
Bill> to the "inode" if you used the data area address, for stat
Bill> that's probaby not an issue, for open after you open the file
Bill> you don't really need access checking and the times on a CD
Bill> don't change.

In isofs, the on-disc `inode' is an iso_directory_record, which
contains the name as well as describing a single extent.
iso_directory_records are chained together for files that have more
than one extent on disc.  The code currently uses iget() to get the
chained iso_directory_records.

Bill> What's the case where you are starting with an inode and trying
Bill> to get to a filename without having gone through a dir entry to
Bill> the inode? No one is running things like dump/restore on iso9660
Bill> I hope!

no it's where you're starting with an inode number, and want to get an
inode.  Having looked at the code, now, I think that that's confined
to autofs and internally to the isofs code, so could be worked around.

Maybe we should deprecate iget() ???

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.


