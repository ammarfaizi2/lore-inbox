Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSKSSe3>; Tue, 19 Nov 2002 13:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267169AbSKSSe3>; Tue, 19 Nov 2002 13:34:29 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:51115 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267166AbSKSSe1>;
	Tue, 19 Nov 2002 13:34:27 -0500
Date: Tue, 19 Nov 2002 10:40:04 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Douglas Gilbert <dougg@torque.net>,
       Andre Hedrick <andre@pyxtechnologies.com>
Cc: "J. E. J. Bottomley" <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.18-modified-scsi-h.patch
Message-ID: <20021119104004.A21438@eng2.beaverton.ibm.com>
References: <Pine.LNX.4.10.10211182138310.2779-200000@master.linux-ide.org> <3DDA0E63.9050307@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3DDA0E63.9050307@torque.net>; from dougg@torque.net on Tue, Nov 19, 2002 at 09:11:47PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:11:47PM +1100, Douglas Gilbert wrote:
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

So we should name it the same in 2.4 as in 2.5: upper_private_data, not
trace_ptr (thought it should really have been sr_upper_private_data,
like all the other fields in scsi_request).

I don't see why we need the #define, or is that another patch?

-- Patrick Mansfield
