Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbSKSGkL>; Tue, 19 Nov 2002 01:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSKSGkL>; Tue, 19 Nov 2002 01:40:11 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:46862
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267114AbSKSGkJ>; Tue, 19 Nov 2002 01:40:09 -0500
Date: Mon, 18 Nov 2002 22:42:54 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Douglas Gilbert <dougg@torque.net>,
       "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
In-Reply-To: <3DD9DA23.1070102@pobox.com>
Message-ID: <Pine.LNX.4.10.10211182239570.2779-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Jeff Garzik wrote:

> Andre Hedrick wrote:
> 
> > Greetings Doug et al.
> >
> > Please consider the addition of this simple void ptr to the scsi_request
> > struct.  The addition of this simple void pointer allows one to map any
> > and all request execution caller the facility to search for a specific
> > operation without having to run in circles.  Hunting for these details
> > over the global device list of all HBA's is silly and one of the key
> > reasons why there error recovery path is so painful.
> >
> >
> > Scsi_Request    *req = sc_cmd->sc_request;
> > blah_blah_t     *trace = NULL;
> >
> > trace = (blah_blah_t *)req->trace_ptr;
> >
> >
> > Therefore the specific transport invoking operations via the midlayer will
> > have the ablity to track and trace any operation.
> >
> > It will save everyone headaches.
> >
> > Cheers,
> >
> >
> > Andre Hedrick, CTO & Founder
> > iSCSI Software Solutions Provider
> > http://www.PyXTechnologies.com/
> >
> >
> > ------------------------------------------------------------------------
> >
> > --- linux/drivers/scsi/scsi.h.orig	2002-10-31 01:45:39.000000000 -0800
> > +++ linux/drivers/scsi/scsi.h	2002-10-31 01:46:31.000000000 -0800
> > @@ -667,8 +667,11 @@
> >  	unsigned short sr_sglist_len;	/* size of malloc'd scatter-gather list */
> >  	unsigned sr_underflow;	/* Return error if less than
> >  				   this amount is transferred */
> > +	void *trace_ptr;	/* capable of cmd-cmnd-error tracing */
> 
> 
> ok
> 
> 
> >  };
> >
> > +#define MODIFIED_SCSI_H
> 
> 
> This falls into C style :)  Instead of this I would do
> 
> 	#define HAVE_TRACE_PTR 1
> 
> just like we already do HAVE_xxx in include/linux/netdevice.h and other 
> places.
> 
> 	Jeff

Works for me, just need to test the state of intelligence of the SCSI
stack and if it is possible to teach the old dog a new trick.  The ablitly
to logically seek an operation without chasing, the link list of devices
and outstanding commands, it tail!

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

