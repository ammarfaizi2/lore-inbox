Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSCVB2e>; Thu, 21 Mar 2002 20:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312607AbSCVB2R>; Thu, 21 Mar 2002 20:28:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4829 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312606AbSCVB2A>;
	Thu, 21 Mar 2002 20:28:00 -0500
Date: Thu, 21 Mar 2002 17:27:55 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2 questions about SCSI initialization
Message-ID: <20020321172755.A20004@eng2.beaverton.ibm.com>
In-Reply-To: <20020321000553.A6704@devserv.devel.redhat.com> <20020321142635.A6555@eng2.beaverton.ibm.com> <20020321190451.A1054@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 07:04:51PM -0500, Pete Zaitcev wrote:
> > Date: Thu, 21 Mar 2002 14:26:35 -0800
> > From: Patrick Mansfield <patmans@us.ibm.com>
> > --- scsi.c.orig	Thu Mar 21 13:51:27 2002
> > +++ scsi.c	Thu Mar 21 13:52:54 2002
> > @@ -2331,8 +2331,8 @@
> >  	/*
> >  	 * If we are busy, this is not going to fly.
> >  	 */
> > -	if (GET_USE_COUNT(tpnt->module) != 0)
> > -		goto error_out;
> > +	if (tpnt->module && (GET_USE_COUNT(tpnt->module) != 0))
> > +		BUG();
> 
> Guaranteed to trigger BUG() is out_of_memory gets set.
> 
> I still think we better kill this check altogether.
> Any more objections?

No objection.

The same problem exists in scsi_unregister_host, where it checks
GET_USE_COUNT(SDpnt->host->hostt->module). It looks like we would
hit this with sd and scsi built into the kernel, and an insmod
of an adapter that hits a scsi_build_commandblocks failure. Correct?

-- Patrick Mansfield

> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
