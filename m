Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUHJKeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUHJKeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUHJKeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:34:08 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:17880 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S264261AbUHJKd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:33:57 -0400
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
Date: Tue, 10 Aug 2004 11:33:55 +0100
Message-Id: <E1BuTx5-0003NI-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@digitalimplant.org> wrote:

> Ok, the patch below attempts to fix up the device power management
> handling, taking into account (hopefully) everything that has been said
> over the last week+, and lessons learned over the years. It's only been
> compile-tested, and is meant just to prove that the framework is possible.
> There are likely to be some missing pieces, mainly because it's late. :)

At the moment I'm struggling with the fact that the order of resumption
of system devices appears significant (ie, I get hangs on resume with
the stock kernel, but changing the list_for_each_entry in sysdev_resume
to list_for_each_entry_reverse makes things work) but there doesn't seem
to be any mechanism for providing proper ordering when there isn't a
tree structure. This also crops up with resuming my wireless hardware -
it tries to do a hotplug firmware load, but the IDE bus hasn't been
woken up yet.

Do we need a more fine-grained dependency structure than the current
tree?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
