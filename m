Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVDEFGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVDEFGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 01:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVDEFGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 01:06:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261562AbVDEFFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 01:05:54 -0400
Date: Tue, 5 Apr 2005 01:05:10 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>,
       "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, <rml@novell.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Netlink Connector / CBUS
Message-ID: <Xine.LNX.4.44.0504050030230.9273-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy,

Please send networking patches to netdev@oss.sgi.com.

Your connector code (under drivers/connector) is now in the -mm tree and 
as far as I can tell, has not received any review from the network 
developers.

Looking at it briefly, it seems quite unfinished.

I'm not entirely sure what it's purpose is.

A clear explanation of its purpose would be helpful (to me, at least), as 
well as documentation of the API and majore data structures (which akpm 
has also asked for, IIRC).

I can see one example of where it's being used with kobject_uevent, and it 
seems to have arrived via Greg-KH's I2C tree...

If you're trying to add a generic, psuedo-reliable Netlink communication 
system, perhaps this should be built into Netlink itself as an extension 
of the existing Netlink API.

I don't think this should be done as a separate "driver" off somewhere 
else with a new API.


A few questions:

- Why does it by default use NETLINK_NFLOG a kernel socket, and also allow 
this to be overriden by a module parameter?

- Why does the cn.o module (poor namespace choice) add a callback itself
on initialization?

- Where is the userspace code which uses this?  I checked out dbus from 
cvs and couldn't see anything obvious.


Thanks,


- James
-- 
James Morris
<jmorris@redhat.com>



