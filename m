Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135804AbREBTiO>; Wed, 2 May 2001 15:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135792AbREBTh4>; Wed, 2 May 2001 15:37:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37091 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S135782AbREBThg>; Wed, 2 May 2001 15:37:36 -0400
Date: Wed, 2 May 2001 11:55:01 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Doug Ledford <dledford@redhat.com>
Cc: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
Message-ID: <20010502115501.A19473@us.ibm.com>
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	Eric.Ayers@intec-telecom-systems.com,
	James Bottomley <James.Bottomley@steeleye.com>,
	"Roets, Chris" <Chris.Roets@compaq.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200105011445.KAA01117@localhost.localdomain><3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <20010502102037.A19349@us.ibm.com> <3AF048FA.1B5EA399@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AF048FA.1B5EA399@redhat.com>; from dledford@redhat.com on Wed, May 02, 2001 at 01:50:50PM -0400
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug,

I guess I worded my question poorly. My question was around multi-path
devices in combination with SCSI-2 reserve vs SCSI-3 persistent reserve which 
has not always been easy, but is more difficult is you use a name space that 
can slip or can have multiple entries for the same physical device you want
to reserve.

But here is a second try.

If this is a failover cluster then node A will need to reserve all disks in 
shareable space using sg or only a subset if node A has sync'd his sd name
space with the other node and they both wish to do work in disjoint pools of
disks.

In the scenario of grabbing all the disks. If sda and sdb are the same device 
than I can only reserve one of them and ensure IO only goes down through the
one I reserver-ed otherwise I could get a reservation conflict. This goes 
along with your previous patch on supporting multi-path at "md" and translating this into the proper device to reserve. I guess it is up to the caller of 
your service to handle this case correct??

If this not any clearer than my last mail I will just wait to see the code
:-).

Thanks,

-Mike

Doug Ledford [dledford@redhat.com] wrote:
> 
> 
> 
> To:   Mike Anderson <mike.anderson@us.ibm.com>
> cc:   Eric.Ayers@intec-telecom-systems.com, James Bottomley
>       <James.Bottomley@steeleye.com>, "Roets, Chris"
>       <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
>       linux-scsi@vger.kernel.org
> 
> 
> 
> 
> 
> Mike Anderson wrote:
> >
> > Doug,
> >
> > A question on clarification.
> >
> > Is the configuration you are testing have both FC adapters going to the
> same
> > port of the storage device (mutli-path) or to different ports of the
> storage
> > device (mulit-port)?
> >
> > The reason I ask is that I thought if you are using SCSI-2 reserves that
> the
> > reserve was on a per initiator basis. How does one know which path has
> the
> > reserve?
> 
> Reservations are global in nature in that a reservation with a device will
> block access to that device from all other initiators, including across
> different ports on multiport devices (or else they are broken and need a
> firmware update).
> 
> > On a side note. I thought the GFS project had up leveled there locking /
> fencing
> > into a API called a locking harness to support different kinds of fencing
> > methods. Any thoughts if this capability could be plugged into this
> service so
> > that users could reduce recoding depending on which fencing support they
> > selected.
> 
> I wouldn't know about that.
> 
> --
> 
>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>       Please check my web site for aic7xxx updates/answers before
>                       e-mailing me about problems

-- 
Michael Anderson
mike.anderson@us.ibm.com

IBM Linux Technology Center - Storage IO
Phone (503) 578-4466
Tie Line: 775-4466

