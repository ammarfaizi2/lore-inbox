Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbSKSSzJ>; Tue, 19 Nov 2002 13:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267290AbSKSSzJ>; Tue, 19 Nov 2002 13:55:09 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:32260
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267283AbSKSSzD>; Tue, 19 Nov 2002 13:55:03 -0500
Date: Tue, 19 Nov 2002 10:48:38 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Douglas Gilbert <dougg@torque.net>,
       "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
In-Reply-To: <20021119104004.A21438@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.10.10211191046110.1342-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Patrick Mansfield wrote:

> On Tue, Nov 19, 2002 at 09:11:47PM +1100, Douglas Gilbert wrote:
> > Andre Hedrick wrote:
> > > Greetings Doug et al.
> > > 
> > > Please consider the addition of this simple void ptr to the scsi_request
> > > struct.  The addition of this simple void pointer allows one to map any
> > > and all request execution caller the facility to search for a specific
> > > operation without having to run in circles.  Hunting for these details
> > > over the global device list of all HBA's is silly and one of the key
> > > reasons why there error recovery path is so painful.
> > > 
> > > 
> > > Scsi_Request    *req = sc_cmd->sc_request;
> > > blah_blah_t     *trace = NULL;
> > > 
> > > trace = (blah_blah_t *)req->trace_ptr;
> > > 
> > > 
> > > Therefore the specific transport invoking operations via the midlayer will
> > > have the ablity to track and trace any operation.
> > 
> > Andre,
> > No need to convince me: I have already put a similar pointer
> > in that structure in lk 2.5 (for either sd, st, sr or sg to use).
> > In sg case's it saved some ugly looping in (what was formerly
> > called) the bottom half handler. Sounds like your motivation is
> > similar.
> > 
> > Doug Gilbert
> 
> So we should name it the same in 2.4 as in 2.5: upper_private_data, not
> trace_ptr (thought it should really have been sr_upper_private_data,
> like all the other fields in scsi_request).
> 
> I don't see why we need the #define, or is that another patch?

Hi Patrick,

The #define was as to determine or notify the driver at build time if it
had an enhanced capablity or legacy restrictions.  Obviously once it is
adopted regardless of form then a simple version check will work.

It was for testing purposes.


Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

