Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261650AbSJQDs2>; Wed, 16 Oct 2002 23:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSJQDs2>; Wed, 16 Oct 2002 23:48:28 -0400
Received: from [203.117.131.12] ([203.117.131.12]:45966 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261650AbSJQDs1>; Wed, 16 Oct 2002 23:48:27 -0400
Message-ID: <3DAE3465.6060006@metaparadigm.com>
Date: Thu, 17 Oct 2002 11:54:13 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
Cc: Simon Roscic <simon.roscic@chello.at>, linux-kernel@vger.kernel.org
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
References: <200210152120.13666.simon.roscic@chello.at>	 <200210152153.08603.simon.roscic@chello.at>	 <3DACD41F.2050405@metaparadigm.com>	 <200210161828.18985.simon.roscic@chello.at>	 <3DAD988B.40704@metaparadigm.com> <1034824350.26.33.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/02 11:12, GrandMasterLee wrote:
> On Wed, 2002-10-16 at 11:49, Michael Clark wrote:
>>Seems to be the correlation so far. qlogic driver without lvm works okay.
>>qlogic driver with lvm, oopsorama.
> 
> 
> Michael, what exactly do your servers do? Are they DB servers with ~1Tb
> connected, or file-servers with hundreds of gigs, etc?

My customer currently has about 400Gb on this particular 4 node Application
cluster (actually 2 x 2 node clusters using kimberlite HA software).

It has 11 logical hosts (services) spread over the 4 nodes with services such
as Oracle 8.1.7, Oracle Financials (11i), a busy openldap server, and busy
netatalk AppleShare Servers, Cyrus IMAP server. All are on ext3 partitions
and were previously using LVM to slice up the storage.

The cluster usually has around 200-300 active users.

We have had oops (in ext3) on differing logical hosts which where running
different services. ie. has oopsed on the node mastering the fileserver,
and also on the node mastering the oracle database.

Cross fingers, since removing LVM (which was the only change we have made,
same kernel) we have had 3 times our longest uptime and still counting.

By the sounds, from earlier emails I had posted, users had responded
to me who were also using qlogic and none of them had had any problems,
the key factor was none of them were running LVM - this is what made
me think to try and remove it (it was really just a hunch). We had
gone through months of changing kernel versions, changing GigE network
adapters, driver versions, etc, to no avail, then finally the LVM removal.

Due to the potential nature of it being a stack problem. The problem
really can't just be pointed at LVM but more the additive effect this
would have on some underlying stack problem.

I believe the RedHat kernels i tried (rh7.2 2.4.9-34 errata was the most
recent) also had this 'stack' problem. I am currently using 2.4.19pre10aa4.

I would hate to reccomend you remove LVM and it not work, but i
must say it has worked for me (i'm just glad i didn't go to XFS instead
of removing LVM as i did - as this was the other option i was pondering).

~mc

