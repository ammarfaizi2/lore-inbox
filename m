Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRCWQ5t>; Fri, 23 Mar 2001 11:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbRCWQ5m>; Fri, 23 Mar 2001 11:57:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17794 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131270AbRCWQ5b>; Fri, 23 Mar 2001 11:57:31 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH] Documentation/ioctl-number.txt)
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF791BBBC5.E3FCBEEE-ON87256A18.005BA3B7@LocalDomain>
From: "Bryan Henderson" <hbryan@us.ibm.com>
Date: Fri, 23 Mar 2001 09:56:47 -0700
X-MIMETrack: Serialize by Router on D03NM088/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 03/23/2001 09:56:48 AM,
	Serialize complete at 03/23/2001 09:56:48 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How it can be used? Well, say it you've mounted JFS on /usr/local
>% mount -t jfsmeta none /mnt -o jfsroot=/usr/local
>% ls /mnt
>stats     control   bootcode whatever_I_bloody_want
>% cat /mnt/stats
>master is on /usr/local
>fragmentation = 5%
>696942 reads, yodda, yodda
>% echo "defrag 69 whatever 42 13" > /mnt/control
>% umount /mnt

There's a lot of cool simplicity in this, both in implementation and 
application, but it leaves something to be desired in functionality.  This 
is partly because the price you pay for being able to use existing, 
well-worn Unix interfaces is the ancient limitations of those interfaces 
-- like the inability to return adequate error information.

Specifically, transactional stuff looks really hard in this method.
If I want the user to know why his "defrag" command failed, how would I 
pass that information back to him?  What if I want to warn him of of a 
filesystem inconsistency I found along the way?  Or inform him of how 
effective the defrag was?  And bear in mind that multiple processes may be 
issuing commands to /mnt/control simultaneously.

With ioctl, I can easily match a response of any kind to a request.  I can 
even return an English text message if I want to be friendly.

