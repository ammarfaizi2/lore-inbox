Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUHJOhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUHJOhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUHJOhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:37:05 -0400
Received: from digitalimplant.org ([64.62.235.95]:40585 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266249AbUHJOgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:36:53 -0400
Date: Tue, 10 Aug 2004 07:36:45 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <E1BuTx5-0003NI-00@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.50.0408100728310.13807-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <E1BuTx5-0003NI-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Matthew Garrett wrote:

> At the moment I'm struggling with the fact that the order of resumption
> of system devices appears significant (ie, I get hangs on resume with
> the stock kernel, but changing the list_for_each_entry in sysdev_resume
> to list_for_each_entry_reverse makes things work) but there doesn't seem
> to be any mechanism for providing proper ordering when there isn't a
> tree structure. This also crops up with resuming my wireless hardware -
> it tries to do a hotplug firmware load, but the IDE bus hasn't been
> woken up yet.

It's not that we need a tree; it's just that we need to take dependency
information into account with system devices, and those aren't necessarily
related to ancestry. That relates to the fact that not enough system
devices have been converted, and not enough time has been spent, to really
understand the dependency information enough to fix the model.

As for the wireless device, I would suggest modifying the driver so that
it retries the hotplug event. Or, perhaps it could be converted to use a
mechanism in which events are not lost (kevents maybe?).


	Pat
