Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265715AbSJYAMJ>; Thu, 24 Oct 2002 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265716AbSJYAMJ>; Thu, 24 Oct 2002 20:12:09 -0400
Received: from [63.204.6.12] ([63.204.6.12]:17820 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S265715AbSJYAMI>;
	Thu, 24 Oct 2002 20:12:08 -0400
Date: Thu, 24 Oct 2002 20:18:19 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Steven Dake <sdake@mvista.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
In-Reply-To: <20021024232258.GA26093@kroah.com>
Message-ID: <Pine.LNX.4.33.0210241956460.10937-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Greg KH wrote:

> On Thu, Oct 24, 2002 at 07:00:23PM -0400, Scott Murray wrote:
> >
> > I've not implemented it yet, but I'm pretty sure I can detect surprise
> > extractions in my cPCI driver.  The only thing holding me back at the
> > moment is that there's no clear way to report this status change via
> > pcihpfs without doing something a bit funky like reporting "-1" in the
> > "adapter" node.
>
> Why would you need to report anything other than if the card is present
> or not?  What would a "supprise" removal cause you to do differently?

Thinking about it a bit more, my idea to use -1 is indeed unnecessary,
since userspace code can check if the adapter node changes to 0 before
it itself writes a 0 to it.  If multiple users/software play around with
the nodes at the same time, they'll get what's coming to them...

> Hm, well I guess we should be extra careful in trying to shut down any
> driver bound to that card...

Yeah, as Steven mentions in his reply, Linux drivers don't handle this
well at the moment.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


