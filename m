Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSKMRRR>; Wed, 13 Nov 2002 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSKMRRR>; Wed, 13 Nov 2002 12:17:17 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:32196 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S262420AbSKMRRQ>; Wed, 13 Nov 2002 12:17:16 -0500
Date: Wed, 13 Nov 2002 09:24:00 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Brian Jackson <brian-kernel-list@mdrx.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Message-ID: <20021113172400.GE806@nic1-pc.us.oracle.com>
References: <20021113002529.7413.qmail@escalade.vistahp.com> <20021113114641.GI19811@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113114641.GI19811@marowsky-bree.de>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:46:41PM +0100, Lars Marowsky-Bree wrote:
> In short, you can do "MD", if you don't use it as "shared"; have only one node
> have a given md device active at any point in time. Thus, no autostart, but
> manual activation. This rules out "GFS over md", basically.

	RAID0 can work fine.  You cannot have a persistent superblock
and autostart, because then the two nodes stomp on each other.  To allow
anything other than this, you'd need cluster services and node locking.
	How to do RAID0?  Have each node mkraid the RAID0 (or mdadm
equiv) at boot.  Because there is no persistent superblock, there is no
contention to the disk.  OpenGFS or OCFS can now share the nice striped
volume, because they handle the locking for their data.
	We have, in fact, run OCFS on shared RAID0 in this fashion.

Joel

-- 

"Maybe the time has drawn the faces I recall.
 But things in this life change very slowly,
 If they ever change at all."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
