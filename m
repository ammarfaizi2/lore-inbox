Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVG0SLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVG0SLs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVG0SLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:11:44 -0400
Received: from pat.qlogic.com ([198.70.193.2]:51804 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S262128AbVG0SLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:11:41 -0400
Date: Wed, 27 Jul 2005 11:11:35 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Greg KH <greg@kroah.com>, kernelnewbies@nl.linux.org,
       linux-scsi@vger.kernel.org, linux-newbie@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Incorrect driver getting loaded for Qlogic FC-HBA
Message-ID: <20050727181135.GI7114@plap.qlogic.org>
References: <b115cb5f0507241902653b6f72@mail.gmail.com> <20050726000600.GB23858@kroah.com> <b115cb5f050725211615cfab78@mail.gmail.com> <20050726155253.GB8462@plap.qlogic.org> <b115cb5f05072623016a713629@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f05072623016a713629@mail.gmail.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 27 Jul 2005 18:11:40.0503 (UTC) FILETIME=[A2FC5670:01C592D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005, Rajat Jain wrote:

> On 7/27/05, Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:
> > 
> > A similar problem was noted with RHEL4, it seems the modules.pcimap
> > and pci.ids file were correct, but the pcitable file contained entries
> > for all ql[ae]23xx based HBAs to load qla2300.ko.
> > 
> > It's my understanding that this was fixed for RHEL4 U1.  Which distro
> > are you using?  If you are using RHEL, and are still having problems,
> > I'd suggest you file a report with Redhat.
> > 
> > Regards,
> > Andrew Vasquez
> > 
> 
> BINGO! I AM using RHEL 4. So does that mean I can rectify the problem
> by making appropriate changes to "pcitable" file?

I'm trying to get a firm answer from the folks who originally
discvoered the problem some time back, it seems you have two options:

 - during installation of RHEL4 (and not RHEL4U1), load with the
   'noprobe' option:

	linux noprobe

   and manually select the appropriate drivers to load.

 - (post installation) modify the /etc/modprobe.conf to and rename the
   qla2300 entry to qla2322 (i.e.):

	alias scsi_hostadapter1 qla2322

   modify the modules.pcimap table to load qla2322 for the 2322
   device-id:

	qla2300		0x00001077	0x00002322	...

   to:

	qla2322		0x00001077	0x00002322	...


Beyond that, I'd suggest you log a report with Redhat, as that's the
extent of the workaround knowledge without going to RHEL4U1.

Hope this helps,
Andrew Vasquez
