Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTDWNqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 09:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTDWNqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 09:46:20 -0400
Received: from [81.80.245.157] ([81.80.245.157]:21933 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264046AbTDWNqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 09:46:18 -0400
Date: Wed, 23 Apr 2003 15:58:14 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Tony Spinillo <tspinillo@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423135814.GJ820@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Tony Spinillo <tspinillo@yahoo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423133256.GG354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:32:56AM -0400, Ben Collins wrote:

> > Can we see it please ?
> 
> Stelia,
> 
> http://www.linux1394.org/viewcvs/ieee1394/branches/linux-2.4
> 
> Click the "Download tarball" link and replace drivers/ieee1394 with what
> you get.

Hey, that's a whole new version of ieee1394 subsystem, see below the
diffstat.

There is *NO WAY* Marcelo will accept such a patch in the -rc stage.

>From a quick reading, your version seem to do exactly the same thing
that my patch suggested (removing the spinlock around kernel_thread()),
possibly with the locking being moved to the upper layer.

Do you have a stripped down patch correcting only the outstanding issues ?
If you haven't, the choice will be either accepting my patch or 
reverting your entire ieee1394 changes for the time being.

Stelian.


 amdtp.c                 |   78 ++--
 cmp.c                   |   70 ---
 csr.c                   |   14 
 dv1394-private.h        |    2 
 dv1394.c                |   12 
 eth1394.c               |  110 +-----
 eth1394.h               |    1 
 highlevel.c             |  247 +++++++++++--
 highlevel.h             |   26 +
 hosts.c                 |   68 +--
 hosts.h                 |   21 -
 ieee1394-ioctl.h        |    4 
 ieee1394.h              |   10 
 ieee1394_core.c         |  232 +++++++++---
 ieee1394_core.h         |   15 
 ieee1394_hotplug.h      |    2 
 ieee1394_transactions.c |  473 ++++++++++---------------
 ieee1394_transactions.h |   57 ---
 ieee1394_types.h        |   26 +
 nodemgr.c               |  344 +++++++++---------
 nodemgr.h               |   23 -
 ohci1394.c              |   37 --
 pcilynx.c               |  119 +++++-
 raw1394-private.h       |    1 
 raw1394.c               |  151 +++-----
 sbp2.c                  |  875 +++++++++++++++++-------------------------------
 sbp2.h                  |  149 ++------
 video1394.c             |  136 ++-----
 video1394.h             |    1 
 29 files changed, 1562 insertions(+), 1742 deletions(-)


-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
