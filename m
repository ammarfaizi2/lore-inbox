Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJWDpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJWDpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUJVTki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:40:38 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9725 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267164AbUJVTde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:33:34 -0400
Message-ID: <4179607A.8030204@nortelnetworks.com>
Date: Fri, 22 Oct 2004 13:33:14 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
CC: root@chaos.analogic.com, andre@tomt.net,
       Kasper Sandberg <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost> <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com> <41792C36.4070301@users.sourceforge.net> <Pine.LNX.4.61.0410221208230.17016@chaos.analogic.com> <41795E69.9090909@cs.aau.dk>
In-Reply-To: <41795E69.9090909@cs.aau.dk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen wrote:

> Anyway - How does this work in practice? Does the file system 
> implementation use a wrapper for kfree or?

When an app faults in new memory and there is no unused memory, the system will 
page out apps and/or filesystem data from the page cache so the memory can be 
given to the app requesting it.

> Is there any way to force instant free of kernel memory - when freed?

It's not free, it's in use by the page cache.  This is a performance feature--we 
try and keep around as much stuff as possible that might be needed by running apps.

> Else it is quite hard testing for possible memory leaks in our Umbrella 
> kernel module ... :-/

Such is life.  As a crude workaround, on a swapless system you can start one or 
two memory hogs and they will force the system to free up as much memory as 
possible.

Chris
