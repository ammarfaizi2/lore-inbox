Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316668AbSEQTxP>; Fri, 17 May 2002 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316671AbSEQTxO>; Fri, 17 May 2002 15:53:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10507 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316668AbSEQTxN>;
	Fri, 17 May 2002 15:53:13 -0400
Message-ID: <3CE55F63.19F7D0E1@zip.com.au>
Date: Fri, 17 May 2002 12:52:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Rival <frival@zk3.dec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops on 2.5.15 with ext3 & AIM 7 shared workload
In-Reply-To: <Pine.LNX.4.32.0205171451440.19851-100000@harley.zk3.dec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Rival wrote:
> 
> I've recently built a 2x300MHz P2 system with 512MB of memory for a simple
> x86 testbed.  To start with, I ran the AIM VII shared workload on the
> system, using the 18 SCSI disks that I have available with ext2
> filesystems.  I got the following oops when I rebooted and started the run
> with ext3.  This was only at the simulated '100 users' load point; the
> system is capable of ~1100 simulated users (i.e. the system was hardly
> heavily loaded).  Does this look familiar to anyone, or is there
> somehting anyone needs me to do?  Thanks!
> 
>  - Pete
> 
> Assertion failure in journal_commit_transaction() at commit.c:523:

(When reporting ext3 problems, please specify the journalling
 mode - it makes a rather large difference).

I'll assume it's data=ordered.   If you're using data=journal
then please don't - it's not working very well in 2.5.15.

These patches:

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.15/ext3-no-steal.patch
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.15/sct-jbddirty.patch

Will likely fix it.  Please let me know...

-
