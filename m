Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267279AbUBSGcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 01:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267282AbUBSGcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 01:32:02 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:52376 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267279AbUBSGb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 01:31:58 -0500
Date: Thu, 19 Feb 2004 06:28:43 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: David Schwartz <davids@webmaster.com>
cc: hasso@estpak.ee, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: raw sockets and blocking
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.58.0402190622010.25392@fogarty.jakma.org>
References: <MDEHLPKNGKAHNMBLJOLKMENGKHAA.davids@webmaster.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004, David Schwartz wrote:

> 	Then the kernel is broken. It must not block an operation
> indefinitely when that operation can complete without blocking.

Aha.

> 	It is, however, perfectly legal to say an operation can
> complete without blocking (say, through 'select' or 'poll') and
> later return EWOULDBLOCK. (So long as some operation could have
> completed, not necessarily the one you tried.)

Right. But that's fine, we can deal with that, if the error is
posted.

Problem is no error is posted when we sendmsg[1], yet the socket
thereafter stays write-blocked, with (sane) way for us to recover.  
(until presumably link comes back, for what ever reason,
unfortunately the OSPF RFCs do not mandate for hosts to have robots
attached to do media maintenance :) ).

In short, for raw sockets at least, the kernel needs to either:

- post an error for writes to raw sockets if they will block

or 

- if the network driver concerned is not ready to take the packet,
drop the packet right there. (upper layers (ie userspace, eg ospfd)  
will follow their own procedures for dealing with packet loss/down
interfaces.)

> 	DS

1. Least, Hasso has not reported the relevant error message occuring.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Your own qualities will help prevent your advancement in the world.
