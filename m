Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUFNW4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUFNW4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUFNW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:56:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:39863 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264571AbUFNW4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:56:39 -0400
Subject: Re: upcalls from kernel code to user space daemons
From: Steve French <smfltc@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200406142341.13340.oliver@neukum.org>
References: <1087236468.10367.27.camel@stevef95.austin.ibm.com>
	 <40CDEECF.7060102@nortelnetworks.com>
	 <200406142341.13340.oliver@neukum.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1087253679.10367.41.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 Jun 2004 17:54:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-14 at 16:40, Oliver Neukum wrote:
> > > 1) getHostByName:  when the kernel cifs code detects a server crashes
> > > and fails reconnecting the socket and the kernel code wants to see if
> > > the hostname now has a new ip address.
> 
> Is that possible at all? It looks like that might deadlock in the page
> out code path.
> 

Yes - since an upcall (indirectly) to a different process while in write
could cause writepage to write out memory to a mount - which could hang
if on an already dead tcp session, this (reconnection - failover to new
ip address if the server ip address changes after failure) may be too
risky to do in the context of writepage, but there may be a way to keep
refusing to do writepage while in the midst of this harder form of mount
reconnection - which isn't likely to be any worse than not
reconnecting.  Fortunately, most tcp reconnection cases are much
simpler.


