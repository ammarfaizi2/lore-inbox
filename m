Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318893AbSICSTX>; Tue, 3 Sep 2002 14:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSICSTX>; Tue, 3 Sep 2002 14:19:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50882 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318838AbSICSTV>; Tue, 3 Sep 2002 14:19:21 -0400
Date: Tue, 3 Sep 2002 14:23:53 -0400
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020903142353.A12157@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <200209031435.g83EZ2F03562@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209031435.g83EZ2F03562@localhost.localdomain>; from James.Bottomley@steeleye.com on Tue, Sep 03, 2002 at 09:35:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 09:35:02AM -0500, James Bottomley wrote:
> 
> 1) Quiesce host (set in_recovery flag)

Right.

> 2) Suspend active timers on this host

Right.

> 3) Proceed down the error correction track (eliminate abort and go down 
> device, bus and host resets and finally set the device offline).

Leave abort active.  It does actually work in certain scenarios.  The CD 
burner scenario that started this thread is an example of somewhere that 
an abort should actually do the job.

> 5) On each error recovery wait out a recovery timer for the device to become 
> active before talking to it again.  Send all affected commands back to the 
> block layer to await reissue (note: it would now be illegal for commands to 
> lie to the mid layer and say they've done the reset when they haven't).
> 6) issue a TUR using a command allocated to the eh for that purpose.  Process 
> the return code (in particular, if the device says NOT READY, wait some more). 
>  Only if the TUR definitively fails proceed up the recovery chain all the way 
> to taking the device offline.

Right.

> I also plan to expose the suspend and resume timers API in some form for FC 
> drivers to use.



-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
