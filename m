Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbTDAUNl>; Tue, 1 Apr 2003 15:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTDAUNl>; Tue, 1 Apr 2003 15:13:41 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:55813 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262837AbTDAUN3>; Tue, 1 Apr 2003 15:13:29 -0500
Date: Tue, 1 Apr 2003 12:24:46 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Partition check order in fs/partition/check.c?
Message-ID: <20030401202446.GB4078@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com> <20030401113503.A30470@flint.arm.linux.org.uk> <200304011316.h31DFwTR039380@d06relay02.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304011316.h31DFwTR039380@d06relay02.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:14:56PM +0200, Peter Oberparleiter wrote:
> Hm, what do you think of these additional checks:
> 
> 1. Check for overlap of partitions

Be very careful here.  While you better not _use_ overlapping
partitions, a partition table with overlapping partitions is
a traditional UNIX default.  It is usually something like

	part	start	length
	a	0	3/8 drive
	b	3/8	1/8 drive
	c	0	whole drive
	d	0	1/3 drive
	e	1/3	1/3 drive
	f	2/3	1/3 drive
	g	1/3	2/3 drive
	h	1/2	1/2 drive

In this way admins wouldn't repartition, just use the default
partitions in suitable combinations.  This actually reduced
the likelihood of overlapping partitions because the
partitioning tools were sometimes confusing causing custom
partition to have 1 cylinder overlaps.  When drives got to be
larger than 2GB these default partition sizes became
increasingly pointless.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
