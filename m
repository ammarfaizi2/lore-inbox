Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTFPXDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTFPXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 19:03:25 -0400
Received: from [64.237.107.19] ([64.237.107.19]:34577 "EHLO NewBlue.Scyld.com")
	by vger.kernel.org with ESMTP id S264436AbTFPXDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 19:03:24 -0400
Date: Mon, 16 Jun 2003 19:02:43 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Nivedita Singhvi <niv@us.ibm.com>
cc: Janice M Girouard <janiceg@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, Jeff Garzik <jgarzik@pobox.com>,
       <davem@redhat.com>
Subject: Re: patch for common networking error messages
In-Reply-To: <3EEE40F1.4030107@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0306161819290.1475-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Nivedita Singhvi wrote:
> Janice M Girouard wrote:
> 
> > Below is a patch that demonstrates standard messages for ethernet device 
> > drivers.  I would like your feedback on the concept of standard network 
> > messages, and any suggestions for messages to include. 

There are many things that can go wrong, and most of them are very
dependent on the NIC's architecture.  A few minutes of thought would
lead to the understanding that a enforced-common list of error/problem
messages is equivalent to a set of error counters.  We have had that
since the initial Linux network hardware layer design.  (Note: BSD of
that era had only a single "error" counter. )

> Essentially, things like some guidelines on classifying some
> of those messages, when creating new messages. eg when is
> something a state change and when is it a performance event?

The NETIF_MSG_* enable bits classify the status message types.

> I'd certainly like to see messages from the driver when the
> card enters/leaves promiscuous mode, as an example of things
> we'd like to add...

Most Ethernet drivers should already do this, right around the message
		/* Unconditionally log net taps. */

> > 2) Reduce the number of puzzling messages that are logged -- in this 
> > case, by replacing them with standard messages, and/or
> > 3) Identify the device (or driver name) that is responsible for the error.

The (physical) interface name, dev->name, should prefix every error
message.  This is a recommendation, not enforced, so not every driver
does it.
  [[[
    Comment: Status/error messages are not an area to demonstrate
    creativity, but all too frequently it becomes one.
  ]]]

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
914 Bay Ridge Road, Suite 220		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993

