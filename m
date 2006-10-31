Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423764AbWJaScn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423764AbWJaScn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423773AbWJaScn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:32:43 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:61254 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423764AbWJaScm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:32:42 -0500
Date: Tue, 31 Oct 2006 20:32:39 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error handling
Message-ID: <20061031183239.GE4698@rhun.ibm.com>
References: <45468845.20400@us.ibm.com> <20061031105452.GD28239@rhun.haifa.ibm.com> <454791A5.9000202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454791A5.9000202@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:10:45AM -0800, Darrick J. Wong wrote:
> Muli Ben-Yehuda wrote:
> 
> > I'm still seeing this on my x366 with the V17 sequencer firmware (with
> > the old Razor sequencer it happens as well, but rarely).
> > 
> > aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x6
> > aic94xx: tmf tasklet complete
> > aic94xx: tmf resp tasklet
> > aic94xx: tmf came back
> > aic94xx: task not done, clearing nexus
> > aic94xx: asd_clear_nexus_tag: PRE
> > aic94xx: asd_clear_nexus_tag: POST
> > aic94xx: asd_clear_nexus_tag: clear nexus posted, waiting...
> > aic94xx: task 0xffff81015ee59580 done with opcode 0x23 resp 0x0 stat 0x8d but aborted by upper layer!
> > aic94xx: asd_clear_nexus_tasklet_complete: here
> > aic94xx: asd_clear_nexus_tasklet_complete: opcode: 0x0
> > aic94xx: came back from clear nexus
> > aic94xx: task 0xffff81015ee59580 aborted, res: 0x0
> > sas: command 0xffff8100e2afcb00, task 0xffff81015ee59580, aborted by initiator: EH_NOT_HANDLED
> > sas: Enter sas_scsi_recover_host
> > sas: going over list...
> > sas: trying to find task 0xffff81015ee59580
> > sas: sas_scsi_find_task: task 0xffff81015ee59580 already aborted
> > sas: sas_scsi_recover_host: task 0xffff81015ee59580 is aborted
> > sas: --- Exit sas_scsi_recover_host
> 
> Yes, the patch doesn't eliminate these errors; it merely does something
> more intelligent with the error code than "Sit around and wait for
> everything to time out"... despite the scary error messages, it looks
> like it's doing the right thing.  However, it'd be useful to have
> timestamps on the printks to know for sure.

Ok, I'll re-run with printk timestamps.

> > aic94xx: escb_tasklet_complete: REQ_TASK_ABORT, reason=0x5
> 
> Break recv'd... that's a new one.
> 
> > sas: DOING DISCOVERY on port 0, pid:1105
> > scsi 0:0:0:0: Direct-Access     IBM-ESXS ST936701SS    F  B512 PQ: 0 ANSI: 4
> 
> Hrm, you might want to update your disks to the latest firmware levels
> (B51C)... be wary that the firmware updates occasionally nuke everything
> on the drive. :(

Pointers to the updated firmware and how to update it?

Cheers,
Muli


