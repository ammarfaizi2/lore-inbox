Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268954AbRH1Ucv>; Tue, 28 Aug 2001 16:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRH1Ucl>; Tue, 28 Aug 2001 16:32:41 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:33802 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268954AbRH1Uca>; Tue, 28 Aug 2001 16:32:30 -0400
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200108282032.f7SKWgZ18130@shaggy.austin.ibm.com>
Subject: Re: Jfs bug ?
To: caszonyi@yahoo.com (szonyi calin)
Date: Tue, 28 Aug 2001 15:32:42 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, jfs-discussion@www-124.southbury.usf.ibm.com
In-Reply-To: <20010826151449.99510.qmail@web13108.mail.yahoo.com> from "szonyi calin" at Aug 26, 2001 08:14:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be discussed in jfs-discussion@www-124.ibm.com since
jfs is not included in either Linus' or Alan's kernels.

> Hi 
> I just formated one of mine linux partitions with jfs 
> I had the following problems
> 
> When restoring from backup
> 
> jfs_strtoUCS: char2uni returned -22.
> charset = iso8859-1, char = 0xffffff99
> jfs_strtoUCS: char2uni returned -22.
> charset = iso8859-1, char = 0xffffff99
> jfs_strtoUCS: char2uni returned -22.
> charset = iso8859-1, char = 0xffffff99
> jfs_strtoUCS: char2uni returned -22.
> charset = iso8859-1, char = 0xffffff99

First, char is simply "99", but it is being sign-extended.

A pathname in the backup has the character 0x99 which is
apparently not valid in the iso8859-1 codepage.  Can you tell
me what filesystem the backup was made from, and do you know
what codepage it used?  Currently, JFS uses whatever codepage
is compiled into the kernel as CONFIG_NLS_DEFAULT.  There
should probably be a mount flag that JFS uses to override this
value, but we don't have that yet.

Anyway, JFS probably substituted a "?" for the 0x99 in the
pathname, and created the file without any further problems.

I'm not sure about the hangs you described.  I'm currently
looking at some hangs that usually only occur under heavy
stress.  It would be useful to have a stack trace from the
hanging threads, especially the [jfsCommit] thread.

-- 
David Kleikamp
IBM Linux Technology Center
