Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319125AbSIDKnd>; Wed, 4 Sep 2002 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSIDKnd>; Wed, 4 Sep 2002 06:43:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62009 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S319107AbSIDKnc>; Wed, 4 Sep 2002 06:43:32 -0400
Date: Wed, 4 Sep 2002 06:48:06 -0400
From: Doug Ledford <dledford@redhat.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020904064806.B12420@redhat.com>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <dledford@redhat.com> <20020903171321.A12201@redhat.com> <200209032148.g83LmeP09177@localhost.localdomain> <20020904103737.GA9936@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020904103737.GA9936@win.tue.nl>; from aebr@win.tue.nl on Wed, Sep 04, 2002 at 12:37:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 12:37:37PM +0200, Andries Brouwer wrote:
> 
> The scsi error recovery has many bad properties, but one is its slowness.

This does not have to be this way.  It is a solvable problem.

> Once it gets triggered on a machine with SCSI disks it is common to
> have a dead system for several minutes.

Yes, well, this too is solvable.  It, in fact, reminds me that one of the 
things I think needs added to the scsi host settings is a default timeout 
value for typical devices.  Something like adding a default_timeout value 
to each Scsi_Device struct and allowing the scsi driver to modify the 
value during the slave_attach() call.  Then we can put the default timeout 
on non-intelligent controllers to something sane while things like 
MegaRAID controllers can keep their sky high timeout values.

> I have not yet met a situation
> in which rebooting was not preferable above scsi error recovery,
> especially since the attempt to recover often fails.

This, too, is solvable.  It just requires that the scsi subsystem start 
paying attention to *how* things fail and making the error handling code 
smart enough to know when to retry things and when to just fail.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
