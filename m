Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbTDANF1>; Tue, 1 Apr 2003 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbTDANF1>; Tue, 1 Apr 2003 08:05:27 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:32948 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262509AbTDANFR>; Tue, 1 Apr 2003 08:05:17 -0500
Message-Id: <200304011316.h31DFwTR039380@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Peter Oberparleiter <Peter.Oberparleiter@gmx.de>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Partition check order in fs/partition/check.c?
Date: Tue, 1 Apr 2003 15:14:56 +0200
X-Mailer: KMail [version 1.3.1]
References: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com> <20030401113503.A30470@flint.arm.linux.org.uk>
In-Reply-To: <20030401113503.A30470@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 April 2003 12:35, you wrote:
[info about acorn partitioning schemes]
Ok, thanks for the explanation about the scheme dependencies. I guess adding 
a comment like "/* this must come before msdos */" in the respective line of 
fs/partition/check.c could cut down in the number of people asking you the 
same question over and over again.. :-)

> > Also, is there a way to make the acorn test more specific?
>
> s/acorn/powertec/
>
> We may be able to check that start,start+size lies within the overall
> drive size.  Whether this solves the problem will depend upon the contents
> of sector 0 for the x86 drives which clash.  However, as drive sizes
> increase, this test will become less and less effective (and at 2TiB
> it doesn't help at all.
Hm, what do you think of these additional checks:

1. Check for overlap of partitions
2. Check for number of recognized partitions (i.e. size != 0) > 0 
3. Check for struct ptec_partition.unused1, unused2, unused5 == 0 (assuming 
they default to zero)

Anyway, thanks again for the info.


Regards,
  Peter Oberparleiter
