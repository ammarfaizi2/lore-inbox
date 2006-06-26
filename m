Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWFZRFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWFZRFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFZRFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:05:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29884 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751062AbWFZRFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:05:05 -0400
Date: Mon, 26 Jun 2006 13:04:40 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Neela.Kolli@engenio.com, linux-scsi@vger.kernel.org,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060626170440.GF8985@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1lkrjub2m.fsf@ebiederm.dsl.xmission.com> <E717642AF17E744CA95C070CA815AE550E1555@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E717642AF17E744CA95C070CA815AE550E1555@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 11:51:52AM -0500, Miller, Mike (OS Dev) wrote:
[..]
> > kdump or taking crash dumps using the kexec on panic 
> > mechanism could be called a drivers worst nightmare.  In the 
> > latest distros this is becoming the way crash dump style 
> > information is captured.
> > 
> > Because the initial kernel is broken we do a jump into 
> > another kernel that is sufficient to record a crash dump.  
> > That second kernel initializes the hardware from whatever 
> > random state the first kernel left the drivers in.  That 
> > first kernel is not permitted to do any device shutdown activities.
> > 
> > The problem is that a command the running instance of the 
> > driver did not initiate completes.  At least if I read Vivek 
> > patch 2/2 correctly.
> > 
> > So we have three options.
> > - reset the card during initialization.
> > - handle the case of a command we did not initiate completing.
> > - mark the driver/card as impossibly hopeless for use in a crash
> >   dump scenario.
> > 
> > 
> > Eric
> 
> Thanks Eric, that helps me understand. Section 8.2.2 of the open cciss
> spec supports a reset message. Target 0x00 is the controller. We could
> add this to the init routine to ensure the board is made sane again but
> this would drastically increase init time under normal circumstances.
> And I suspect this is a hard reset, also. Not sure if that would
> negatively impact kdump. If there were some condition we could test
> against and perform the reset when that condition is met it would not
> impact 99.9% of users.

That's the precise reason of introducing the "crashboot" command line
parameter. Driver authors can check against this condition and reset
the device and 99.9% of the users are not impacted.

Thanks
Vivek

