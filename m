Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbTK0M4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 07:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTK0M4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 07:56:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4515 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264510AbTK0M4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 07:56:10 -0500
Date: Thu, 27 Nov 2003 13:56:09 +0100
From: Jan Kara <jack@suse.cz>
To: Jamie Clark <jclark@metaparadigm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23pre6aa3 - possible ext3 deadlock
Message-ID: <20031127125609.GD17707@atrey.karlin.mff.cuni.cz>
References: <3FA713B9.3040405@metaparadigm.com> <20031104102816.GB2984@x30.random> <3FA79308.3070300@metaparadigm.com> <3FC56DB2.2060704@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC56DB2.2060704@metaparadigm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Followup to last test with 2.4.23pre6aa3. same config as before (ext3 
> /ql2300 / bonnie++) I forgot to mention that I have quotas enabled on 
> the partition under test.
> 
> There have been a few 2.4 / quota / ext3 deadlock-type  mails on the 
> list recently so I'm sot sure if this is related. I can see an atime 
> update in the call trace of one of the bonnies but no dquot_ calls 
> anywhere.  I haven't applied Jan's patch as it came out before I could 
> reliably reproduce this problem.
  Yes, actually there's still a deadlock there for ext3+quotas (patch is
already written but not yet included in mainline I think) but as I've
looked through the trace it doesn't seem to be the case. About a week
ago I saw a report on deadlock of 2.4.22 with just plain ext3 without
quotas - so can you try to reproduce the problem with quotas not
compiled into the kernel (or just turning them off should be enough)?

> In the meantime I'll restart testing with noatime - which is how I'd 
> usually mount such a fs anyhow.
> 
> The box seems to deadlock after 3-6 days of filesystem exercise. I have 
> repeated this 3 times. The last run was 6 days and and then I see all 
> disk I/O has ceased. The system remains pingable and sshd connects at 
> the TCP layer but nothing happens after that. The root filesystem is 
> ext3 but is a completely separate device (motherboard scsi) to the 
> filesystems running bonnie (external FC RAID). It seems that all 
> filesystem activity ceases.
> 
> I have run the alt-sysrq-t ouput through ksymoops and attached.  Hope 
> this is useful to someone who knows.

						Thanks for report
								Honza
