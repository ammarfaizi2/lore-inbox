Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319337AbSIKVMB>; Wed, 11 Sep 2002 17:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319339AbSIKVMA>; Wed, 11 Sep 2002 17:12:00 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25009 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319337AbSIKVL6>;
	Wed, 11 Sep 2002 17:11:58 -0400
Date: Wed, 11 Sep 2002 14:17:35 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020911211735.GE5534@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <patmans@us.ibm.com> <200209111420.g8BEKdx01979@localhost.localdomain> <20020911163013.B26367@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911163013.B26367@redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford [dledford@redhat.com] wrote:
> On Wed, Sep 11, 2002 at 09:20:38AM -0500, James Bottomley wrote:
> > patmans@us.ibm.com said:
> >  I did say 
> > when the patches first surfaced that I didn't like the idea of replacing 
> > Scsi_Device with Scsi_Path at the bottom and the concomitant changes to all 
> > the Low Level Drivers which want to support multi-pathing.  If this is to go 
> > in the SCSI subsystem it has to be self contained, transparent and easily 
> > isolated.  That means the LLDs shouldn't have to be multipath aware.
> 
> I agree with this.
> 

In the mid-level mp patch the adapters are not aware of multi-path. The
changes to adapters carried in the patch have to do with a driver not
allowing aborts during link down cases or iterating over the host_queue
for ioctl, /proc reasons. The hiding of some of the lists behind APIs is
something I had to do in the host list cleanup. We might even do some of
this same list cleanup outside of mp.

Also add "my me to" on the scsi error handling is lacking statement. I
am currently trying to do something about not using the failed command
for error recovery (post abort).

-Mike
-- 
Michael Anderson
andmike@us.ibm.com

