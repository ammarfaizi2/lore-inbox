Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSKSMJp>; Tue, 19 Nov 2002 07:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSKSMJo>; Tue, 19 Nov 2002 07:09:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:4100 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265222AbSKSMJm>; Tue, 19 Nov 2002 07:09:42 -0500
Date: Tue, 19 Nov 2002 04:16:35 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Douglas Gilbert <dougg@torque.net>
cc: "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
In-Reply-To: <3DDA0E63.9050307@torque.net>
Message-ID: <Pine.LNX.4.10.10211190350490.371-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Douglas Gilbert wrote:

> Andre Hedrick wrote:
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
> 
> Andre,
> No need to convince me: I have already put a similar pointer
> in that structure in lk 2.5 (for either sd, st, sr or sg to use).
> In sg case's it saved some ugly looping in (what was formerly
> called) the bottom half handler. Sounds like your motivation is
> similar.
> 
> Doug Gilbert

Hey there!

Well it needs to be in all kernels regardless, and if it is in the
scsi_request it is transparent to any given personality device and the
caller may reserve the option to include other key information.  Simple
stats of what the queue depth of a given device is and a means to flush
out the commands to force a failure in the case of calling a device reset.

Without being to obvious or rude about the driver model being top down and
not the converse, hunting for given set of operation(s) will almost insure
a driver/device deadlock when racing against the done function.

I am pleased you and I are thinking in the same direction again!

Cheers,

Andre Hedrick, CTO & Founder 
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/


