Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUH0JTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUH0JTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269315AbUH0JTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:19:06 -0400
Received: from mail1.kontent.de ([81.88.34.36]:59009 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S269342AbUH0JOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:14:22 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 27 Aug 2004 11:15:55 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com, alan@redhat.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408270004.16534.oliver@neukum.org> <20040827032554.GB30820@babylon.d2dc.net>
In-Reply-To: <20040827032554.GB30820@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408271115.55891.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 27. August 2004 05:25 schrieb Zephaniah E. Hull:
> On Fri, Aug 27, 2004 at 12:04:15AM +0200, Oliver Neukum wrote:
> > 
> > > > Storage cannot do concurrent IO.
> > > 
> > > I'm going to jump in here and ask a simple question, what is the
> > > blocking point that stops writes happening concurrent with reads?
> > 
> > The protocol on USB allows one command at a time only.
> 
> Are you sure on that?  Before some of the locking changes it was
> possible with usbfs to issue a bulk request that may block on the
> device, then issue a bulk write before it finished. (Sometimes the write
> tells the other end to send stuff with the read.)
> 
> Was this violating the spec or just an odd corner case?

6.2.1.
The device shall consider the CBW valid when:
- The CBW was recieved when the device had sent a CSW or after a reset

Sending two requests without reading the CSW in between is illegal.
So a storage device can only execute one command at a time.
As you have to evaluate the CSW just queuing the requests buys you little
and in terms of memory allocation is worse.
Besides, this applies only to the bulk only protocol variant and the storage
driver shall be universal.

	Regards
		Oliver
