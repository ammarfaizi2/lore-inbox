Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312616AbSCVBos>; Thu, 21 Mar 2002 20:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312617AbSCVBoj>; Thu, 21 Mar 2002 20:44:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12610 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312616AbSCVBo2>; Thu, 21 Mar 2002 20:44:28 -0500
Date: Thu, 21 Mar 2002 20:44:26 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020321204426.A16545@devserv.devel.redhat.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com> <20020321142635.A6555@eng2.beaverton.ibm.com> <20020321190451.A1054@devserv.devel.redhat.com> <20020321172755.A20004@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 21 Mar 2002 17:27:55 -0800
> From: Patrick Mansfield <patmans@us.ibm.com>

> The same problem exists in scsi_unregister_host, where it checks
> GET_USE_COUNT(SDpnt->host->hostt->module). It looks like we would
> hit this with sd and scsi built into the kernel, and an insmod
> of an adapter that hits a scsi_build_commandblocks failure. Correct?

I saw that too, but I am less enthusiastic about it for selfish
reasons: no bug is filed against me. There's also one more small
thing: for a host such a check _may_ make some sense.
Target drivers interface file system from their top, so they
get their module usage incremented (and from there, they may
safely increment their usage more if they, say, have outstanding
commands, as Doug explained previously). This is not the case with
host adapter drivers. I simply do not have a complete analysis.
Obviously, the code is broken, but I do not know how to fix it.

All that code is a hell on Earth, I tell you. I am happy that
Marcelo accepted my "detected" counters, but I think that in a
year someone will step into the very same trap with 2.6. Whole
SCSI needs an overhaul. Wanna be Andre Hendriks of SCSI?

-- Pete
