Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264984AbUISXyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbUISXyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUISXyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 19:54:13 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:64207 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264984AbUISXyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 19:54:09 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: =?ISO-8859-1?Q?Rapha=EBl_Rigo?= <raphael.rigo@twilight-hall.net>
Date: Mon, 20 Sep 2004 09:53:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16718.7181.394343.887783@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RAID1 Bug] bio too big device md0 (248 > 200) (2.6.9-rc2-mm1)
In-Reply-To: message from  =?ISO-8859-1?Q?=20Rapha=EBl?= Rigo on Monday September 20
References: <414E076F.5010801@twilight-hall.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday September 20, raphael.rigo@twilight-hall.net wrote:
> Hello,
> kernel version : 2.6.9-rc2-mm1
> i'm using a RAID1 array over 2 disks : one ATA, and another one in 
> "SATA" (if we can call the ICH5 a real SATA controller).
> During array synchronisation, I get "bio too big device md0 (248 > 200)" 
> error, which I fixed in doing
> //#define RESYNC_BLOCK_SIZE (64*1024)
> #define RESYNC_BLOCK_SIZE PAGE_SIZE
> in raid1.c, following the instruction on an old thread (for kernel 2.6.0).
> I would like to know if there is any better fix now, else then this mail 
>   will act as a remainder ;)

This is not (as far as I can tell) a raid1 bug.

   bio too big device md0

means that someone sent a request to md0 that was too large. (124K
instead of the max 100K).

raid1 never does that.  It send requests to the underlying devices.
So if you make your raid1 from hde and sda, then a message like
   bio to big device sda
might indicate a problem with raid1.

Are you sure you quoted the error message correctly?
If you, how was the array being used? What filesystem?

NeilBrown
