Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUA3O1k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA3O1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:27:40 -0500
Received: from mail.humboldt.co.uk ([81.2.65.18]:11418 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S261464AbUA3O1h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:27:37 -0500
Subject: Re: question about PCI setup with multiple CPUs on the PCI bus(es)
From: Adrian Cox <adrian@humboldt.co.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, mj@ucw.cz
In-Reply-To: <401941C4.4070502@nortelnetworks.com>
References: <401941C4.4070502@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1075472830.18271.7.camel@newt>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 14:27:10 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-29 at 17:24, Chris Friesen wrote:
> Surely we aren't the only people that want to put multiple CPUs on a 
> single PCI space.  How have people handled this in the past?  Ideally 
> what I'm looking for is a CONFIG_NO_MANGLE_PCI or something to that 
> effect. As a last resort we are considering hardcoding the bus/device 
> topology for the two drivers on special daughterboard, but this seems 
> really kludgy.
> 
> Anyone have any advice?

Having done this a few times before, the basic advice is to design with
a non-transparent bridge, such as an Intel 2155x or a PLX 6254/6540.
That's too late to save you, so you'll need a nasty hack instead.

Faced with your situation, I dealt with it by declaring one processor to
be the root of the PCI bus, and having a task on that processor read the
bus address of each PCI device, and pass those bus addresses to the
processors that needed them. Only the root processor ever made
configuration cycles.

- Adrian Cox
http://www.humboldt.co.uk/


