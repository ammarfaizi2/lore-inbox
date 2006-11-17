Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933605AbWKQN1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933605AbWKQN1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933606AbWKQN1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:27:06 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:34528 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S933605AbWKQN1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:27:03 -0500
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [RFC][PATCH 5/8] RSS controller task migration support
Cc: ckrm-tech@lists.sourceforge.net, dev@openvz.org, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohitseth@google.com
Message-Id: <20061117132533.A5FCF1B6A2@openx4.frec.bull.fr>
Date: Fri, 17 Nov 2006 14:25:33 +0100 (CET)
From: Patrick.Le-Dot@bull.net (Patrick.Le-Dot)
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/11/2006 14:32:36,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 17/11/2006 14:32:36,
	Serialize complete at 17/11/2006 14:32:36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> For implementing guarantees, we can use limits. Please see
> http://wiki.openvz.org/Containers/Guarantees_for_resources.

Nack.

This seems to be correct for resources like cpu, disk or network
bandwidth but not for the memory just because nobody in this wiki
speaks about the kswapd and page reclaim (but it's true that a such
demon does not exist for cpu, disk or... then the problem is more
simple).

For a customer the main reason to use guarantee is to be sure that
some pages of a job remain in memory when the system is low on free
memory. This should be true even for a job in group/container A with
a smooth activity compared to a group/container B with a set of jobs
using memory more agressively...

What happens if we use limits to implement guarantees ?

>> ...
>> The idea of getting a guarantee is simple:
>> if any group gi requires a Gi units of resource from R units available
>> then limiting all the rest groups with R - Gi units provides a desired
>> guarantee

If the limit is a "hard limit" then we have implemented reservation and
this is too strict.

If the limit is a "soft limit" then group/container B is autorized to
use more than the limit and nothing is guaranteed for group/container A...

Patrick
